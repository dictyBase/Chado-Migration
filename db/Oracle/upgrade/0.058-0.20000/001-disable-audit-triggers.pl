use strict;
use warnings;

use DBIx::Class::DeploymentHandler::DeployMethod::SQL::Translator::ScriptHelpers
   'schema_from_schema_loader';
    
schema_from_schema_loader({ naming => 'v4' },  sub {
	my ($schema, $version_set) = @_;

        $schema->storage->dbh_do(
            sub {
                my ( $storage, $dbh ) = @_;

                my $sth = $dbh->prepare(
                    qq{SELECT trigger_name from 
                    	user_triggers where
						triggering_event = 'UPDATE OR DELETE'
					}
                );
                $sth->execute;

                my $guard = $storage->txn_scope_guard;
                while ( my ($row) = $sth->fetchrow_array ) {
                    next if $row !~ /^AUD/;
                    $dbh->do(qq{ALTER TRIGGER $row DISABLE});
                }
                $guard->commit;
            },
        );

});
