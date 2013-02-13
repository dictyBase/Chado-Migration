    ## -- patch script created by Modware::Chado::Migration module
    use strict;

    package GORef;

    use Moose;

    has 'source' => (
        is      => 'ro',
        isa     => 'Str',
        default => 'GO_REF',
        lazy    => 1
    );

    has 'type' => (
        is      => 'ro',
        isa     => 'Str',
        default => 'GO reference',
        lazy    => 1
    );

    has [qw/go_ref_id title year abstract authors/] => (
        is  => 'rw',
        isa => 'Str'
    );

    has [qw/alt_id external_accession citation url comment is_obsolete/] => (
        is  => 'rw',
        isa => 'Str'
    );

    1;

    package Runnable;

    use IO::File;
    use IO::String;
    use Moose;
    use Modware::Publication::DictyBase;
    use Text::Names qw/parseName isCommonSurname isCommonFirstname/;

    has 'authors' => (
        traits  => ['Hash'],
        is      => 'rw',
        isa     => 'HashRef',
        handles => { set_author => 'set', has_author => 'exists' },
    );

    sub set_authors {
        my ( $self, $names ) = @_;
        my $FH = IO::String->new($names);
        my $i  = 0;
        while ( my $line = $FH->getline ) {
            chomp($line);
            $self->set_author( $line => $i );
            $i = $i + 1;
        }
    }

    sub parse_go_ref {
        my ( $self, $input ) = @_;
        my $io     = IO::String->new($input);
        my $go_ref = GORef->new;
        my @go_refs;
        while ( my $line = $io->getline ) {
            chomp($line);
            next if $line =~ /^!/x;
            if ( !$line ) {
                if ( $go_ref->go_ref_id ) {
                    push( @go_refs, $go_ref );
                    $go_ref = GORef->new;
                    next;
                }
                next;
            }
            elsif ( $io->eof ) {
                push( @go_refs, $go_ref );
            }
            my ( $id, $val ) = split( ':', $line, 2 );
            if ( $id eq 'year' && $val =~ m/\-/g ) {
                my ( $y1, $y2 ) = split( '-', $val );
                $val = $y2;
            }
            $id = $self->trim($id);
            if ($id) {
                $go_ref->$id( $self->trim($val) );
            }
        }
        return @go_refs;
    }

    sub trim {
        my ( $self, $s ) = @_;
        chomp($s);
        $s =~ s/^\s+//;
        return $s;
    }

    sub handle_authors {
        my ( $self, $authors, $ref ) = @_;
        my $tmp_auth = $authors;
        if ( $tmp_auth =~ m/\(.*?\)/g ) {
            $tmp_auth =~ s/\(.*?\)//gs;
        }
        my @authors;
        if ( $tmp_auth =~ m/,/g ) {
            @authors = split( ', ', $tmp_auth );
        }
        else {
            push( @authors, $tmp_auth );
        }
        my $auth_count = 1;
        foreach my $auth (@authors) {
            $auth = $self->trim($auth);
            if ( $auth =~ m/;/g ) {
                my ( $org, $name ) = split( ';', $auth );
                $auth = $self->trim($name);
            }
            my @names = parseName($auth);
            if ( $names[0] =~ m/\s/g ) {
                my @name_space = split( ' \s', $names[0] );
                $names[0] = $name_space[0];
            }
            if (   isCommonFirstname( $names[0] )
                || isCommonSurname( $names[1] )
                || $self->has_author($auth) )
            {
                $ref->add_author(
                    Modware::Publication::Author->new(
                        last_name  => $names[1],
                        first_name => $names[0],
                        rank       => $auth_count++
                    )
                );
            }

            else {
                my $mod_group = Modware::Publication::Author->new(
                    last_name => $auth,
                    rank      => $auth_count++
                );
                $ref->add_author($mod_group);
            }
        }
        return $ref;
    }

    1;

    use LWP::UserAgent;
    use Modware::DataSource::Chado;

    sub {
        my ( $dh, $dir, $logger, $release ) = @_;

        # - $dh: Modware::Chado::Migration deployment handler object
        #       call $dh->schema to get Bio::Chado::Schema object
        # ** make sure you use transaction for writing to database

        # - $dir: A Path::Class::Dir object representing the data folder.
        # - $logger: A Log::Contextual::WarnLogger object.
        # - $release: The release no under which the code is going to run.

        ## -- patch code below

        Modware::DataSource::Chado->register_handler(
            Modware::DataSource::Chado->default_source,
            $dh->schema );
        transform( Modware::DataSource::Chado->instance );

        my $run = Runnable->new;

        my $ua       = LWP::UserAgent->new;
        my $url      = 'http://www.geneontology.org/doc/GO.references';
        my $response = $ua->get($url);
        my @go_refs;
        if ( $response->is_success ) {
            @go_refs = $run->parse_go_ref( $response->decoded_content );
        }

        my $names
            = "Alessandro Sette\nGiorgio Valle\nPompeo Volpe\nBali Pulendran\nQ. Alison Yao\nPascale Gaudet\nWasila Dahdul\nCeri Van Slyke\nChristopher J. Mungall\nAlexander D. Diehl";

        if ($names) {
            $run->set_authors($names);
        }

        # -- code below run under a transaction
        my $guard = $dh->schema->txn_scope_guard;

        foreach my $go_ref (@go_refs) {
            my $id = $go_ref->go_ref_id;
            next if ( !$id );
            $id =~ s/^GO_REF://x;
            my $ref = Modware::Publication::DictyBase->new( id => $id );
            $ref->source( $go_ref->source );
            $ref->type( $go_ref->type );
            $ref->title( $go_ref->title );
            $ref->year( $go_ref->year )         if $go_ref->year;
            $ref->abstract( $go_ref->abstract ) if $go_ref->abstract;
            $ref->full_text_url( $go_ref->url ) if $go_ref->url;

            if ( $go_ref->authors ) {
                $ref = $run->handle_authors( $go_ref->authors, $ref );
            }
            $ref->create;
        }
        $guard->commit;
        print scalar(@go_refs) - 1 . " GO_REF references created\n";

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
