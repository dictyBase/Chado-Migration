            ## -- patch script created by Modware::Chado::Migration module
            use strict;
            use Bio::Biblio::IO;
            use File::Find::Rule;
            use Modware::Publication::DictyBase;
            use Modware::DataSource::Chado;
            use Modware::Publication::Author;

            sub {
                my ( $dh, $dir, $log, $release ) = @_;

                # - $dh: Modware::Chado::Migration deployment handler object
                #       call $dh->schema to get Bio::Chado::Schema object
                # ** make sure you use transaction for writing to database

             # - $dir: A Path::Class::Dir object representing the data folder.
             # - $logger: A Log::Contextual::WarnLogger object.

                ## -- patch code below
                my @files = File::Find::Rule->file->name(qr/pubmed/)
                    ->in( $dir->subdir($release)->stringify );

                Modware::DataSource::Chado->register_handler(
                    Modware::DataSource::Chado->default_source,
                    $dh->schema );
                load_entry( $_, $log ) for @files;

                sub load_entry {
                    my ( $file, $log ) = @_;
                    my $biblio = Bio::Biblio::IO->new(
                        -format => 'pubmedxml',
                        -file   => $file
                    );

                    $log->info( 'going to load file ' . $file );
                    while ( my $entry = $biblio->next_bibref ) {
                        my $pubmed_id = $entry->pmid;
                        if (my $exist
                            = Modware::Publication::DictyBase
                            ->find_by_pubmed_id(
                                $pubmed_id)
                            )
                        {
                            $log->warn("Publication with $pubmed_id exist");
                            next;
                        }

                        my $pub = Modware::Publication::DictyBase->new(
                            pubmed_id => $pubmed_id,
                            source    => 'PUBMED', 
                            type      => $entry->type,
                            title     => $entry->title,
                            volume    => $entry->volume,
                            year      => $entry->date,
                            status    => $entry->pubmed_status
                        );
                        for my $slot (qw/issue abstract/) {
                            $pub->$slot( $entry->$slot ) if $entry->$slot;
                        }
                        $pub->abstract( $entry->abstract )
                            if $entry->abstract;

                        if ( my $journal = $entry->journal ) {
                            my $abbr = $journal->abbreviation;
                            my $name = $journal->name;
                            if ( $name and $abbr ) {
                                $pub->journal($name);
                                $pub->abbreviation($abbr);
                            }
                            elsif ($name) {
                                $pub->journal($name);
                                $pub->abbreviation($name);
                            }
                            elsif ($abbr) {
                                $pub->journal($abbr);
                                $pub->abbreviation($abbr);
                            }
                            else {
                                $log->warn(
                                    "no journal name or abbreviation found for $pubmed_id"
                                );
                            }
                        }

                        for my $pub_author ( @{ $entry->authors } ) {
                            my $author = Modware::Publication::Author->new;
                            for my $api (qw/initials suffix/) {
                                if (    $pub_author->can($api)
                                    and $pub_author->$api )
                                {
                                    $author->$api( $pub_author->$api );
                                }
                            }
                            $author->first_name( $pub_author->forename )
                                if $pub_author->can('forename')
                                    and $pub_author->forename;
                            $author->last_name( $pub_author->lastname )
                                if $pub_author->can('lastname')
                                    and $pub_author->lastname;
                            if (   $author->has_last_name
                                or $author->has_given_name )
                            {
                                $pub->add_author($author);
                            }
                        }
                        $pub->create;
                        $log->info("loadded $pubmed_id from $file");
                    }

                }
              }

