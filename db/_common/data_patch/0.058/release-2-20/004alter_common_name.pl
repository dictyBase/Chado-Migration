    ## -- patch script created by Modware::Chado::Migration module
    use strict;

    sub {
    	my ($dh, $dir, $logger) = @_;
    	# - $dh: Modware::Chado::Migration deployment handler object
    	#       call $dh->schema to get Bio::Chado::Schema object
    	# ** make sure you use transaction for writing to database

    	# - $dir: A Path::Class::Dir object representing the data folder. 
    	# - $logger: A Log::Contextual::WarnLogger object.

    	## -- patch code below

    	my $schema = $dh->schema;
    	my $org = $schema->resultset('Organism::Organism')->find({
    		'species' => 'purpureum', 
    		'genus' => 'Dictyostelium'
    	});
    	if (!$org) {
    		$logger->warn('Could not find purpureum in the database');
    		return;
    	}

		# -- code below run under a transaction
    	my $guard = $schema->storage->txn_scope_guard;
		$org->update({'common_name' => 'purpureum'});
		$guard->commit;

		$logger->info('updated common name for purpureum');

    }
