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

        my $pubmed_id = 18413355;

        my $schema = $dh->schema;

        # -- code below run under a transaction

        my $pub =
          $schema->resultset('Pub::Pub')->find( { uniquename => $pubmed_id } );
        if ( !$pub ) {
            $logger->error("Could not find PMID $pubmed_id in database");
            return;
        }
        my $id = $pub->pub_id;

        my $stash;

        my $supercontig_rs =
          $schema->resultset('Organism::Organism')
          ->search( { 'common_name' => 'fasciculatum' } )->search_related(
            'features',
            {
                'type.name'   => 'supercontig',
                'type_2.name' => 'mitochondrial_DNA'
            },
            { join => [ 'type', { 'featureprops' => 'type' } ] }
          );

        push @$stash, [ $supercontig_rs->first->feature_id, $id ];

        my $gene_rs =
          $supercontig_rs->search_related( 'feature_relationship_objects',
            {}, {} )->search_related(
            'subject',
            { 'type_3.name' => 'gene' },
            { join          => 'type' }
            );

        while ( my $row = $gene_rs->next ) {
            push @$stash, [ $row->feature_id, $id ];
        }

        my $rna_rs =
          $gene_rs->search_related( 'feature_relationship_objects', {}, {} )
          ->search_related(
            'subject',
            { 'type_4.name' => { 'in', [ 'mRNA', 'tRNA' ] } },
            { join => 'type' }
          );

        while ( my $row = $rna_rs->next ) {
            push @$stash, [ $row->feature_id, $id ];
        }

        #my $poly_rs =
        #  $rna_rs->search_related( 'feature_relationship_objects', {}, {} )
        #  ->search_related(
        #    'subject',
        #    { 'type_5.name' => 'polypeptide' },
        #    { join          => 'type' }
        #  );

        my $guard = $schema->txn_scope_guard;

        if ( defined @$stash ) {
            unshift @$stash, [qw/feature_id pub_id/];
            $schema->resultset('Sequence::FeaturePub')->populate($stash);
        }
        $guard->commit;
        $logger->info( "Added PMID $pubmed_id to "
              . @$stash
              . " features of fasciculatum" );
      }

