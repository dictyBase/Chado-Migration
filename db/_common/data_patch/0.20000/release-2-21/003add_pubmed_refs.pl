    ## -- patch script created by Modware::Chado::Migration module
    use strict;

    use Bio::DB::EUtilities;
    use Modware::DataSource::Chado;
    use Modware::Publication::DictyBase;
    use XML::Twig::XPath;

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
        Modware::DataSource::Chado->register_handler(
            Modware::DataSource::Chado->default_source, $schema );
        transform( Modware::DataSource::Chado->instance );

        my @pmids = qw/16854454 16495485 10888671 15470500 10459012/;

        # -- code below run under a transaction
        my $guard = $schema->txn_scope_guard;

        for my $pmid (@pmids) {
            my $eutil = Bio::DB::EUtilities->new(
                -eutil => 'efetch',
                -id    => $pmid,
                -db    => 'pubmed',
                -email => 'foo@bar.org'
            );
            if ( $eutil->get_Response->is_error() ) {
                die $eutil->get_Response->message(), "\n";
            }

            my $twig = XML::Twig::XPath->new->parse(
                $eutil->get_Response->content() );

            my $ref = Modware::Publication::DictyBase->new( id => $pmid );
            $ref->source('PUBMED');

            my ($title) = $twig->findnodes('//Article/ArticleTitle');
            $ref->title( $title->getValue );

            my ($year)
                = $twig->findnodes(
                '//Article/Journal/JournalIssue/PubDate/Year');
            $ref->year( $year->getValue );

            my ($issue)
                = $twig->findnodes('//Article/Journal/JournalIssue/Issue');
            $ref->issue( $issue->getValue ) if $issue;

            my ($volume)
                = $twig->findnodes('//Article//Journal/JournalIssue/Volume');
            $ref->volume( $volume->getValue ) if $volume;

            my ($journal) = $twig->findnodes('//Article/Journal/Title');
            $ref->journal( $journal->getValue ) if $journal;

            my ($abstract)
                = $twig->findnodes('//Article/Abstract/AbstractText');
            $ref->abstract( $abstract->getValue ) if $abstract;

            my $auth_count = 1;
            my @authors    = $twig->findnodes('//Article/AuthorList/Author');
            foreach my $author (@authors) {
                $ref->add_author(
                    Modware::Publication::Author->new(
                        last_name  => $author->first_child_text,
                        first_name => $author->last_child_text,
                        rank       => $auth_count++
                    )
                );
            }
            $ref->create;
        }

        $guard->commit;

        sub transform {
            my ($schema) = @_;
            my $source = $schema->handler->source('Pub::Pub');
            $source->remove_column('title');
            $source->add_column(
                'title' => {
                    data_type   => 'clob',
                    is_nullable => 1
                }
            );
            $source->remove_column('uniquename');
            $source->add_column(
                'uniquename' => {
                    date_type   => 'number',
                    is_nullable => 0
                }
            );
            my $source2 = $schema->handler->source('Pub::Pubprop');
            $source2->remove_column('value');
            $source2->add_column(
                'value' => {
                    date_type   => 'clob',
                    is_nullable => 0
                }
            );
            return $schema;
        }
        }
