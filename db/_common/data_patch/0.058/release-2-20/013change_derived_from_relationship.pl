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
        my $rs     = $schema->resultset('Cv::Cv')
            ->search( { 'me.name' => 'relationship' } );
        my $wouldbe_term = $rs->search_related(
            'cvterms',
            { 'cvterms.name' => 'derives_from' },
            { 'rows' => 1 }
        )->single;

        # -- code below run under a transaction
        my $guard = $schema->txn_scope_guard;
        my $retval
            = $rs->search_related( 'cvterms', { 'cvterms.name' => 'derived_from' } )
            ->search_related( 'feature_relationships', {} )
            ->update( { 'type_id' => $wouldbe_term->cvterm_id } );
        $guard->commit;
        $logger->info(
            "replaced derived_from term with derives_from having return value $retval"
        );

        }
