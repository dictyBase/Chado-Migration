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
            if ( $name =~ /|/ ) {
                my @products = split /|/, $name;
                for my $i ( 0 .. $#products ) {
                    push @$featureprops,
                        {
                        feature_id => $row->feature_id,
                        value      => $products[$i],
                        type_id    => $type_id,
                        rank       => $i
                        };
                }
            }
            else {
                push @$featureprops,
                    {
                    feature_id => $row->feature_id,
                    value      => $name,
                    type_id    => $type_id
                    };
            }

            if ( @$featureprops and @$featureprops == 2000 ) {
                unshift @$featureprops, [qw/feature_id value type_id rank/];
                $schema->resultset('Sequence::Featureprop')
                    ->populate($featureprops);
                $logger->info("loaded product name for 2000 records");
                undef $featureprops;
            }

        }

        if (@$featureprops) {
            unshift @$featureprops, [qw/feature_id value type_id rank/];
            $schema->resultset('Sequence::Featureprop')
                ->populate($featureprops);
            $log->info(
                "loaded rest of " . @$featureprops . " product name" );
        }
        $guard->commit;
        }
