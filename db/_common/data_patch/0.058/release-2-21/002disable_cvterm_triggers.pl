    ## -- patch script created by Modware::Chado::Migration module
    use strict;

    sub {
    	my ($dh, $dir, $logger, $release) = @_;
    	# - $dh: Modware::Chado::Migration deployment handler object
    	#       call $dh->schema to get Bio::Chado::Schema object
    	# ** make sure you use transaction for writing to database

    	# - $dir: A Path::Class::Dir object representing the data folder. 
    	# - $logger: A Log::Contextual::WarnLogger object.
    	# - $release: The release no under which the code is going to run.

    	## -- patch code below

    	my $schema = $dh->schema;
        $schema->storage->dbh_do(
            sub {
                my ( $storage, $dbh ) = @_;

                my $sth = $dbh->prepare(
                    qq{SELECT trigger_name from 
                    	user_triggers where
						triggering_event = 'UPDATE OR DELETE'
						AND
						table_name IN ('CV',  'CVPROP', 'CVTERM',  'CVTERM_RELATIONSHIP',
						'DBXREF',  'DB',  'CVTERMSYNONYM')
					}
                );
                $sth->execute;

                my $guard = $storage->txn_scope_guard;
                while ( my ($row) = $sth->fetchrow_array ) {
                    next if $row !~ /^AUD/;
                    $dbh->do(qq{ALTER TRIGGER $row DISABLE});
                    $logger->trace("Disabled trigger $row");
                }
                $guard->commit;
                $logger->info('All triggers disabled');
            },
        );
		

    }
