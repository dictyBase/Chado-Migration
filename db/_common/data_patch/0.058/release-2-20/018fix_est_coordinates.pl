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
        my $rs     = $schema->resultset('Sequence::Feature')->search(
            {   'type.name'            => 'EST',
                'organism.common_name' => 'purpureum'
            },
            {   join => [
                    qw/type
                        organism/
                ]
            }
        )->search_related( 'featureloc_features', { 'rank' => 0 } );
	
        # -- code below run under a transaction
        my $guard = $schema->txn_scope_guard;
        while (my $row = $rs->next) {
        	$row->update({fmin => $row->fmin - 1});
        }
        $guard->commit;
        $logger->info("updated ".$rs->count." EST coordinates");

        }
