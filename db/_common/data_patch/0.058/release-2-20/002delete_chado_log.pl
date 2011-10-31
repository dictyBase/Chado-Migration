    ## -- patch script created by Modware::Chado::Migration module
    use strict;
    sub {
        my ( $dh, $dir, $logger ) = @_;

        # - $dh: Modware::Chado::Migration deployment handler object
        #       call $dh->schema to get Bio::Chado::Schema object
        # ** make sure you use transaction for writing to database

        # - $dir: A Path::Class::Dir object representing the data folder.

        ## -- patch code below

        my $schema = $dh->schema;
        $schema->storage->dbh_do(
            sub {
                my ( $storage, $dbh ) = @_;
                my $guard = $storage->txn_scope_guard;
                $dbh->do(qq{DROP TABLE CHADO_LOGS cascade constraints });
                $guard->commit;
                $logger->info('dropped chadoprop table');
            },
        );

        }
