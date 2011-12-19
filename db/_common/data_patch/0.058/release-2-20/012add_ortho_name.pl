    ## -- patch script created by Modware::Chado::Migration module
    use strict;

    sub {
        my ( $dh, $dir, $logger, $release ) = @_;

        # - $dh: Modware::Chado::Migration deployment handler object
        #       call $dh->schema to get Bio::Chado::Schema object
        # ** make sure you use transaction for writing to database

        # - $dir: A Path::Class::Dir object representing the data folder.
        # - $logger: A Log::Contextual::WarnLogger object.

        ## -- patch code below
        my $input = $dir->subdir($release)->file('dpur_ortho.txt')->openr;

        my $schema = $dh->schema;

        ## -- get the cvterm id
        my $cvrow
            = $schema->resultset('Cv::Cvterm')
            ->find(
            { 'me.name' => 'product', 'cv.name' => 'feature_property' },
            { join      => 'cv' } );
        if ( !$cvrow ) {
            $logger->error("product cvterm not found in the database");
            $logger->error("the patch cannot be run");
            return;
        }
        my $type_id = $cvrow->cvterm_id;

        # -- code below run under a transaction
        my $guard = $schema->txn_scope_guard;

	    my $commit_threshold = 2000;
        my $featureprops;
        while ( my $line = $input->getline ) {
            chomp $line;
            my ( $id, $name ) = split /\t/, $line;
            my $row = $schema->resultset('Sequence::Feature')
                ->find( { 'uniquename' => $id } );

            if ( !$row ) {
                $logger->warn("cannot find $id in the database");
                next;
            }
            if ( $name =~ /\|/ ) {
                my @products = split /\|/, $name;
                for my $i ( 0 .. $#products ) {
                    push @$featureprops,
                        [ $row->feature_id, $products[$i], $type_id, $i ];
                }
            }
            else {
                push @$featureprops, [ $row->feature_id, $name, $type_id, 0 ];
            }

            if ( @$featureprops >= $commit_threshold ) {
                unshift @$featureprops, [qw/feature_id value type_id rank/];
                $logger->info("going to load $commit_threshold entries");
                $schema->resultset('Sequence::Featureprop')
                    ->populate($featureprops);
                $logger->info("loaded product name for $commit_threshold records");
                undef $featureprops;
            }

        }

        if (defined @$featureprops) {
            unshift @$featureprops, [qw/feature_id value type_id rank/];
            $logger->info("going to load rest of the entries");
            $schema->resultset('Sequence::Featureprop')
                ->populate($featureprops);
            $logger->info(
                "loaded rest of " . scalar @$featureprops . " product name" );
        }
        $guard->commit;
        }
