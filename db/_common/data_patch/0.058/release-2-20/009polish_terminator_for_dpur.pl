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
		# -- code below run under a transaction
		my $rows = $schema->storage->dbh_do(
			sub {
				my ($st, $dbh) = @_;
    			my $guard = $schema->txn_scope_guard;
    			my $rows = $dbh->do(qq{
    				UPDATE feature protein 
    				SET protein.residues = REPLACE(protein.residues, '*'), 
    				protein.seqlen = (protein.seqlen - 1)
    				WHERE protein.type_id = (
    					SELECT cvterm_id FROM cvterm
    					WHERE cvterm.name = 'polypeptide' 
    				)
    				AND
    				protein.organism_id = (
    					SELECT organism_id FROM organism
    					WHERE common_name = 'purpureum'
    				)
    			});
		        $guard->commit;
		        return $rows;
			}
		);
		$logger->info("polished terminator character from $rows polypeptide record");
    }
