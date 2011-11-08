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

        my $schema = $dh->schema;

        my $row = $schema->resultset('Cv::Cvterm')->search(
            {   'cv.name' => 'annotation_properties',
                'me.name' => 'wiki_annotation'
            },
            { join => 'cv', rows => 1 }
        )->single;

        # -- code below run under a transaction

        if ( !$row ) {    ## -- need to create the cvterm
            my $guard = $schema->txn_scope_guard;
            $row = $self->schema->resultset('Cv::Cvterm')->create(
                {   'name'     => 'wiki_annotation',
                    definition => 'Wiki page with additional annotation', 
                        'cv_id' =>
                        $schema->resultset('Cv::Cv')->find_or_create(
                        { 'name' => 'annotation_properties' }
                        )->cv_id,
                    'dbxref' => {
                        'accession' =>
                            'annotation_properties:wiki_annotation',
                        'db_id' => $schema->resultset('General::Db')
                            ->find_or_create( { name => 'null' } )->db_id
                    },
                }
            );

            $guard->commit;
            $logger->info('created wiki annotation cvterm');

        }

        }
