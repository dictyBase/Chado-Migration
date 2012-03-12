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
        my $cvterm = $schema->resultset('Cv::Cvterm')->find(
            {   'name'    => 'nuclear_sequence',
                'cv.name' => 'sequence'
            },
            { join => 'cv' }
        );
        if ( !$cvterm ) {
            $logger->error('cvterm nuclear_sequence is not present');
            $logger->error('the patch is not run');
            return;
        }
        my $type_id = $cvterm->cvterm_id;

        my $rs = $schema->resultset('Sequence::Feature')->search(
            {   'organism.common_name'              => 'purpureum',
                'type.name' => 'supercontig'
            },
            {   join       => [qw/organism type/]
            }
        );

        my $stash;
        while ( my $row = $rs->next ) {
        	push @$stash,  [$row->feature_id, $type_id,  1];
        }

        # -- code below run under a transaction
        my $guard = $schema->txn_scope_guard;
        if (defined @$stash) {
        	unshift @$stash,  [qw/feature_id type_id value/];
        	$schema->resultset('Sequence::Featureprop')->populate($stash);
        }
        $guard->commit;
        $logger->info('added nuclear_sequence cvterm to '.@$stash. ' features of purpureum');

        }
