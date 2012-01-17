    ## -- patch script created by Modware::Chado::Migration module
    use strict;

    sub {
        my ( $dh, $dir, $logger, $release ) = @_;

        # - $dh: Modware::Chado::Migration deployment handler object
        #       call $dh->schema to get Bio::Chado::Schema object
        # ** make sure you use transaction for writing to database

        # - $dir: A Path::Class::Dir object representing the data folder.
        # - $logger: A Log::Contextual::WarnLogger object.
        # - $release: The release no under which the code is going to run.

        ## -- patch code below

        my $schema = $dh->schema;
        my $row    = $schema->resultset('Cv::Cvterm')->find(
            {   name      => 'part_of',
                'cv.name' => 'relationship'
            },
            { join => 'cv' }
        );
        if ( !$row ) {
            $logger->error("could not find cvterm part_of: patch is not run");
            return;
        }
        my $cvterm_id = $row->cvterm_id;
        my $contig_rs = $schema->resultset('Sequence::Feature')->search(
            {   'type.name'            => 'supercontig',
                'organism.common_name' => 'purpureum'
            },
            {   join => [
                    qw/type
                        organism/
                ]
            }
        );
        $logger->info("got ".$contig_rs->count. " contigs");

        # -- code below run under a transaction
        my $guard = $schema->txn_scope_guard;
        while ( my $row = $contig_rs->next ) {
            my $gene_rs
                = $row->search_related( 'featureloc_srcfeatures', {} )
                ->search_related(
                'feature',
                { 'type.name' => 'gene' },
                { join        => 'type' }
                );
            $logger->info( "going to link "
                    . $gene_rs->count
                    . " genes with contig "
                    . $row->uniquename );
            my $data;
            while ( my $gene = $gene_rs->next ) {
                push @$data,
                    [ $cvterm_id, $row->feature_id, $gene->feature_id ];
                if ( defined @$data and @$data >= 3000 ) {
                    unshift @$data, [qw/type_id object_id subject_id/];
                    $schema->resultset('Sequence::FeatureRelationship')
                        ->populate($data);
                    $logger->info(
                        "linked 3000 genes with contig " . $row->uniquename );
                    undef $data;
                }
            }
            if ( defined @$data ) {
                unshift @$data, [qw/type_id object_id subject_id/];
                $schema->resultset('Sequence::FeatureRelationship')
                    ->populate($data);
                $logger->info( "linked rest of the genes with contig "
                        . $row->uniquename );
            }
        }

        $guard->commit;

        }
