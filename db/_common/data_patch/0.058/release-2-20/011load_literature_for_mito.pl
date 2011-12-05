    ## -- patch script created by Modware::Chado::Migration module
    use strict;
    use Modware::Publication::DictyBase;
    use Modware::DataSource::Chado;
    use Modware::Publication::Author;

    sub {
    	my ($dh, $dir, $logger) = @_;
    	# - $dh: Modware::Chado::Migration deployment handler object
    	#       call $dh->schema to get Bio::Chado::Schema object
    	# ** make sure you use transaction for writing to database

    	# - $dir: A Path::Class::Dir object representing the data folder. 
    	# - $logger: A Log::Contextual::WarnLogger object.

    	## -- patch code below
    	my @authors = (
    		[qw/G Burger/], 
    		[qw/AJ Lohan/], 
    		[qw/K Angata/], 
    		[qw/BF Lang/], 
    		[qw/MW Gray/]
    	);
    	my $title1 = 'Complete sequence of Polysphondylium pallidum and Hartmannella vermiformis mitochondrial DNAs';

        Modware::DataSource::Chado->register_handler(
            Modware::DataSource::Chado->default_source,
            $dh->schema );

	   my $pub = Modware::Publication::DictyBase->new(
	   	 title => $title1, 
	   	 status => 'Unpublished'
	   );
	   $pub->add_author(Modware::Publication::Author->new(
	   	first_name => $_->[0], 
	   	last_name => $_->[1]
	   )) for @authors;

	   my $pub_in_db = $pub->create;
	   $logger->info("loaded unpublished article with id ".  $pub_in_db->id);

    }
