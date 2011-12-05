    ## -- patch script created by Modware::Chado::Migration module
    use strict;
    use Digest::MD5 qw/md5_hex/;

    sub {
        my ( $dh, $dir, $log ) = @_;

        # - $dh: Modware::Chado::Migration deployment handler object
        #       call $dh->schema to get Bio::Chado::Schema object
        # ** make sure you use transaction for writing to database

        # - $dir: A Path::Class::Dir object representing the data folder.
        # - $logger: A Log::Contextual::WarnLogger object.

        ## -- patch code below

        my $schema = $dh->schema;

        # -- code below run under a transaction
        my $guard = $schema->txn_scope_guard;

        ## -- get all genes
        my $gene_rs
            = $schema->resultset('Organism::Organism')
            ->search( { 'common_name' => 'purpureum' } )->search_related(
            'features',
            { 'type.name' => 'gene' },
            {   join     => 'type',
                prefetch => 'featureloc_features'
            }
            );
    GENE:
        while ( my $row = $gene_rs->next ) {
            my $floc  = $row->featureloc_features;
            my $start = $floc->first->fmin + 1;
            my $end   = $floc->first->fmax;
            my $rs    = $floc->search_related(
                'srcfeature',
                {},
                {   select =>
                        [ \"SUBSTR(srcfeature.residues, $start , $end)" ],
                    as => 'fseq'
                }
            );
            my $sequence = $rs->first->get_column('fseq');
            $row->update(
                {   residues    => $sequence,
                    md5checksum => md5_hex($sequence),
                    seqlen      => ( $end - $start + 1)
                }
            );

            $log->debug( 'added sequence of gene ' . $row->uniquename );
        }
        $log->info( 'added sequences for all ' . $gene_rs->count . ' genes' );

        my $trans_rs
            = $schema->resultset('Organism::Organism')
            ->search( { 'common_name' => 'purpureum' } )->search_related(
            'features',
            { 'type.name' => { 'like', '%RNA' } },
            {   join     => 'type',
                prefetch => 'featureloc_features'
            }
            );

        while ( my $row = $trans_rs->next ) {
            my @exons = $row->search_related(
                'feature_relationship_objects',
                { 'type.name' => 'part_of' },
                { join        => 'type' }
                )->search_related(
                'subject',
                { 'type_2.name' => 'exon' },
                {   join     => 'type',
                    prefetch => 'featureloc_features'
                }
                )->all;

            if ( !@exons ) {
                $log->warn(
                    sprintf(
                        "no exon for transcript type %s %s",
                        $row->type->name, $row->uniquename
                    )
                );
            }

            my $sequence = '';
            for my $erow (@exons) {
                my $floc  = $erow->featureloc_features;
                my $start = $floc->first->fmin + 1;
                my $end   = $floc->first->fmax;
                $sequence .= $floc->search_related(
                    'srcfeature',
                    {},
                    {   select => [
                            \"SUBSTR(srcfeature.residues, $start,
                            $end)"
                        ],
                        as => 'fseq'
                    }
                )->first->get_column('fseq');

            }
            if ( $row->featureloc_features->first->strand == -1 ) {
                $sequence =~ tr/ATGC/UACG/;
                $sequence = reverse $sequence;
            }
            $row->update(
                {   residues    => $sequence,
                    md5checksum => md5_hex($sequence),
                    seqlen      => length $sequence
                }
            );

            $log->info( 'added sequence for transcript ' . $row->uniquename );
        }
        $log->info(
            'added sequence for ' . $trans_rs->count . ' transcripts' );

        $guard->commit;

    };
