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

        my $rs = $schema->resultset('Sequence::Feature')->search(
            {
                'organism.common_name' => 'fasciculatum',
                'type.name' =>

                  { 'in', [ 'gene', 'supercontig', 'contig', 'mRNA', 'tRNA' ] }
            },
            { join => [ 'organism', 'type' ] }
        );
        my $stash;
        while ( my $row = $rs->next ) {
            push @$stash, [ $row->feature_id, $id ];
        }

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

