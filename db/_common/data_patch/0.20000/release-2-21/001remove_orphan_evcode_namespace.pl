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
        my $cvrow
            = $schema->resultset('Cv::Cv')
            ->find(
            { name => 'file:/Users/mgiglio/obo/ontology/evidence_code.obo' }
            );
        if ( !$cvrow ) {
            $logger->error(
                'Cannot find existing evcode namespace in database');
            return;
        }

        #get all dbxref ids
        my $ids = [ map { $_->dbxref_id }
                $cvrow->search_related( 'cvterms', {} ) ];

        # -- code below run under a transaction
        my $guard = $schema->txn_scope_guard;

        $cvrow->delete;
        $schema->resultset('General::Dbxref')->search( { dbxref_id => $ids } )
            ->delete_all;

        $guard->commit;
        $logger->info('deleted orphan evcode namespace');

        }
