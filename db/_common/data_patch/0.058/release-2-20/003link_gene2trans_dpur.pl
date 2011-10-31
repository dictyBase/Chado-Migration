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

        # cvterm id for relation
        my $cvterm_row = $schema->resultset('Cv::Cvterm')->search(
            {   'me.name' => 'part_of',
                'cv.name' => 'sequence'
            },
            { join => 'cv', 'rows' => 1 }
        )->single;
        my $cvterm_id = $cvterm_row->cvterm_id;

        # get all genes for dpur
        my $gene_rs = $schema->resultset('Sequence::Feature')->search(
            {   'type.name'        => 'gene',
                'organism.species' => 'purpureum',
                'organism.genus'   => 'Dictyostelium'
            },
            {   join     => [qw/type organism/],
                prefetch => 'featureloc_features'
            }
        );

        my $populate_array;
        while ( my $row = $gene_rs->next ) {
            my $feature = $schema->resultset('Sequence::Feature')->search(
                {   'type.name' => 'mRNA',
                    'featureloc_features.fmin' =>
                        $row->featureloc_features->first->fmin,
                    'featureloc_features.fmax' =>
                        $row->featureloc_features->first->fmax,
                    'dbxref.accession' => 'JGI'

                },
                {   join => [
                        'featureloc_features', 'type',
                        { 'feature_dbxrefs' => 'dbxref' }
                    ],
                    rows => 1
                }
            )->single;

            push @$populate_array,
                [ $row->feature_id, $feature->feature_id, $cvterm_id ];

            if ( @$populate_array and @$populate_array == 5000 ) {
                $logger->trace('goint to insert 5000 records');
                unshift @$populate_array, [qw/object_id subject_id type_id/];
                $schema->txn_do(
                    sub {
                        $schema->resultset('Sequence::FeatureRelationship')
                            ->populate($populate_array);
                    }
                );
                $logger->trace('inserted 5000 records');
                undef $populate_array;
            }
        }

        if (@$populate_array) {
            $logger->trace('goint to insert rest of the records');
            $schema->txn_do(
                sub {
                    unshift @$populate_array,
                        [qw/object_id subject_id type_id/];
                    $schema->resultset('Sequence::FeatureRelationship')
                        ->populate($populate_array);
                }
            );
            $logger->trace(
                'inserted rest of '.
                scalar @$populate_array.
                ' records'
            );
        }

        # -- code below run under a transaction

        }
