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

        # -- code below run under a transaction

        ## -- list of polypeptide feature object
        my $rs = $schema->resultset('Sequence::Feature')->search(
            {   'type.name'            => 'polypeptide',
                'organism.common_name' => 'purpureum'
            },
            { join => [qw/organism type/], prefetch => 'dbxref' }
        );
        my $guard = $schema->txn_scope_guard;
        while ( my $row = $rs->next ) {
            my $id = 'DPU'.next_feature_id($schema);
            $row->update({ uniquename => $id } );
            $row->dbxref->update( { accession  => $id } );
        }

        $guard->commit;
        my $count = $rs->count;
        $logger->info("removed trailing P from $count polypeptide entries");

    };

    sub next_feature_id {
        my ($schema) = @_;
        my $id = $schema->storage->dbh_do(
            sub {
                my ( $st, $dbh ) = @_;
                my $id = $dbh->selectcol_arrayref(
                    "SELECT SQ_FEATURE_FEATURE_ID.NEXTVAL FROM DUAL")->[0];
                return $id;
            }
        );
        return sprintf( "%07d", $id );
    }
