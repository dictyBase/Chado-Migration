    ## -- patch script created by Modware::Chado::Migration module
    use strict;

    sub {
        my ( $dh, $dir, $logger ) = @_;

        # - $dh: Modware::Chado::Migration deployment handler object
        #       call $dh->schema to get Bio::Chado::Schema object
        # ** make sure you use transaction for writing to database

        # - $dir: A Path::Class::Dir object representing the data folder.
        # - $logger: A Log::Contextual::WarnLogger object.

        ## -- patch code below

        my $schema  = $dh->schema;
        my $org_row = $schema->resultset('Organism::Organism')->find(
            {   genus   => 'Dictyostelium',
                species => 'purpureum'
            }
        );

        if ( !$org_row ) {
            $logger->warn('Could not find purpureum in the database');
            return;
        }

        my $row = $schema->resultset('Cv::Cvterm')->search(
            {   'cv.name' => 'genome_properties',
                'me.name' => 'loaded_genome'
            },
            { join => 'cv', rows => 1 }
        )->single;

        # -- code below run under a transaction
        my $guard = $schema->txn_scope_guard;
        if ( !$row ) {    ## -- need to create the cvterm
            $row = $self->schema->resultset('Cv::Cvterm')->create(
                {   'name'     => 'loaded_genome',
                    definition => 'Genome loaded in chado database',
                    'cv_id'    => $schema->resultset('Cv::Cv')
                        ->find_or_create( { 'name' => 'genome_properties' } )
                        ->cv_id,
                    'dbxref' => {
                        'accession' => 'genome_properties:loaded_genome',
                        'db_id'     => $schema->resultset('General::Db')
                            ->find_or_create( { name => 'null' } )->db_id
                    },
                }
            );
        }

        $org_row->create_related(
            'organismprops',
            {   value   => '1.0',
                type_id => $row->cvterm_id
            }
        );
        $guard->commit;

        $logger->info("created loaded tag for purpuruem");

        }
