package Modware::Chado::Migration::Build;

use warnings;
use strict;
use Tie::Cache;
use namespace::autoclean;
use Carp;
use Try::Tiny;
use File::Basename;
use Scalar::Util qw/looks_like_number reftype/;
use Moose;
use File::Spec::Functions;
use HTTP::Tiny;
use IPC::Cmd qw/run can_run/;
use JSON;
use Class::MOP;
use Class::Unload;
use Class::Inspector;
use File::Find::Rule;
use File::Path qw/make_path remove_tree/;
use Modware::Chado::Migration;
use Modware::Chado::Schema;
use Modware::Chado::Migration::VersionStorage::Standard;
use Path::Class;
use Log::Contextual::WarnLogger;

extends 'Module::Build';

# Module implementation
#
__PACKAGE__->add_property('dbi_driver');
__PACKAGE__->add_property('schema');
__PACKAGE__->add_property('deploy_handler');
__PACKAGE__->add_property('bcs_base');
__PACKAGE__->add_property('schema_version');

has 'logger' => (
    default => sub {
        return Log::Contextual::WarnLogger->new(
            {   levels     => [qw/trace debug info warn error fatal/],
                env_prefix => 'MODWARE'
            }
        );
    },
    is   => 'ro',
    isa  => 'Log::Contextual::WarnLogger',
    lazy => 1
);

sub ACTION_init_from_scratch {
    my ($self) = @_;

    my $schema_class = $self->args('schema_class');
    ## -- set it to Bio::Chado::Schema for generating sql
    $self->args( 'schema_class' => 'Bio::Chado::Schema ' );

    my $cpanm = can_run('cpanm') or die "cpanm needs to be intalled!";
    if ( Class::Inspector->installed('Bio::Chado::Schema') ) {
        my $file = Class::Inspector->resolved_filename('Bio::Chado::Schema');
        warn "Bio::Chado::Schema is installed at $file location\n";
        warn "Either uninstall it using App::pmuninstall package\n";
        die
            " or generate a self contained local-lib by removing BCS path from INC\n";
    }
    my $base
        = 'http://api.metacpan.org/v0/release/_search?q=release.distribution:';
    my $append = '&field=version:name:author&sort=version:desc&size=10';
    my $url    = $base . 'Bio-Chado-Schema' . $append;
    my $res    = HTTP::Tiny->new->get($url);
    my $ver2url;

    if ( $res->{success} ) {
        my $str = JSON->new->decode( $res->{content} );
        for my $dist_data ( @{ $str->{hits}->{hits} } ) {
            if ( $dist_data->{_source}->{maturity} eq 'released' ) {
                next if $dist_data->{_source}->{version} < 0.08;
                my $download = $dist_data->{_source}->{download_url};
                $download =~ s/cpantesters/metacpan/;
                $ver2url->{ $dist_data->{_source}->{version} } = $download;
            }
        }
        $self->_install_versions( $cpanm, $ver2url );
        $self->_ver2schemas($ver2url);

    }
    else {
        warn "!!! Unable to fetch Bio::Chado::Schema \n";
        $self->args( 'schema_class' => $schema_class );
        die "HTTP code: $res->{status}\nError: $res->{reason}\n";
    }
    $self->args( 'schema_class' => $schema_class );
}

sub _ver2schemas {
    my ( $self, $ver2url ) = @_;
    if ( Class::Inspector->loaded('Bio::Chado::Schema') ) {
        Class::Unload->unload( 'Bio::Chado::Schema::Result::' . $_ )
            for Bio::Chado::Schema->sources;
        Class::Unload->unload('Bio::Chado::Schema');
    }
    for my $v ( keys %$ver2url ) {
        my $module_path = catdir( $self->bcs_base, $v, 'lib', 'perl5' );
        unshift @INC, $module_path;

        Class::MOP::load_class( 'Bio::Chado::Schema', { -version => $v } );
        ## -- unload Cv::Chadoprop source if present as the sql should be loaded
        ## -- separately through version sql file
        if ( grep {/Cv::Chadoprop/} Bio::Chado::Schema->sources ) {
            Bio::Chado::Schema->unregister_source('Cv::Chadoprop');
        }

        $self->ACTION_init;
        $self->schema->storage->disconnect;
        Class::Unload->unload( 'Bio::Chado::Schema::' . $_ )
            for $self->schema->sources;
        Class::Unload->unload('Bio::Chado::Schema');
        shift @INC;
    }
}

sub _install_versions {
    my ( $self, $cpanm, $ver2url ) = @_;
    $self->bcs_base( catdir( $self->base_dir, 'bcs_local' ) );
    my $cmd = [ $cpanm,, '-n', '-l' ];
VERSION:
    for my $v ( keys %$ver2url ) {
        next if -e catdir( $self->bcs_base, $v );
        push @$cmd, catdir( $self->bcs_base, $v ), $ver2url->{$v};

        my ( $success, $error_code, $full_buf, $stdout_buf, $stderr_buf )
            = run( command => $cmd, verbose => 1 );
        if ( !$success ) {
            die "$error_code\n$stdout_buf\n$stderr_buf\n";
        }
        pop @$cmd;
        pop @$cmd;
    }

}

sub ACTION_init {
    my ($self) = @_;
    $self->dbd;
    $self->_setup;
    my $version
        = $self->args('version')
        ? $self->args('version')
        : $self->schema->schema_version;
    $self->schema_version($version);

    if (!-e catfile(
            $self->args('migration_folder'), $self->dbi_driver,
            'deploy',                        $version,
            '001-auto.sql'
        )
        )
    {    ## -- only if the sql dump do not exist

        my $yaml = catdir( $self->args('migration_folder'),
            '_source', 'deploy', $version );
        ## -- yaml source folder has to be removed
        ## -- otherwise backend specific sql will not be generated under deploy
        ## -- subdirectory
        remove_tree( $yaml, { verbose => 1 } ) if -e $yaml;

        $self->deploy_handler->prepare_install;
    }

    ## -- setup common folder
    my $folder = $self->args('migration_folder');
    make_path(
        catdir(
            $folder,  '_common',
            'deploy', $self->deploy_handler->schema_version
        ),
        catdir(
            $folder,      $self->dbi_driver,
            'initialize', $self->deploy_handler->schema_version
        ),
        catdir( $folder, '_common', 'initialize' ),
        catdir( $folder, '_common',            'upgrade',   '_any' ),
        catdir( $folder, '_common',            'downgrade', '_any' ),
        catdir( $folder, '_preprocess_schema', 'upgrade' ),
        catdir( $folder, '_preprocess_schema', 'downgrade' )
    );
}

sub ACTION_deploy {
    my ($self) = @_;
    if ( !Class::Inspector->installed('Bio::Chado::Schema') ) {
        die "Install Bio::Chado::Schema \n";
    }

    $self->depends_on('init');
    $self->deploy_handler->deploy( { version => $self->schema_version } );
    $self->deploy_handler->add_database_version(
        {   schema_version => $self->schema_version,
            chado_version  => $self->args('chado_version')
        }
    );
}

sub ACTION_migrate {
    my ($self) = @_;
    return if !$self->dbd;

    my $schema_class = $self->args('schema_class');
    my $schema
        = $schema_class->connect( $self->args('dsn'), $self->args('user'),
        $self->args('password') );
    $self->schema($schema);

    my $vs = Modware::Chado::Migration::VersionStorage::Standard->new(
        { schema => $self->schema } );
    my $current_version = $vs->version_rs->schema_version;

    my $new_version
        = $self->args('version')
        ? $self->args('version')
        : $self->schema->schema_version;

    my $version_set = $self->_version_set( $current_version, $new_version );

    my $dh = Modware::Chado::Migration->new(
        {   schema              => $schema,
            databases           => $self->dbi_driver,
            script_directory    => $self->args('migration_folder'),
            sql_translator_args => {
                filters        => [ sub { $self->_clean_phylonode(@_) } ],
                add_drop_table => 0
            },
            force_overwrite  => 1,
            version_set      => $version_set,
            database_version => $current_version,
            to_version       => $new_version,
            builder          => $self
        }
    );
    $self->deploy_handler($dh);

    my $prep_method = 'prepare_upgrade';
    my $direction   = 'upgrade';
    $version_set = [ sort { $a <=> $b } @$version_set ];

    if ( $current_version > $new_version ) {
        $prep_method = 'prepare_downgrade';
        $direction   = 'downgrade';
        $version_set = [ sort { $b <=> $a } @$version_set ];
    }

    if ( @$version_set == 2 ) {
        $self->deploy_handler->$prep_method(
            {   from_version => $version_set->[0],
                to_version   => $version_set->[1],
                version_set  => $version_set
            }
        );
    }
    else {
        for my $i ( 0 .. scalar @$version_set - 2 ) {
            $self->deploy_handler->$prep_method(
                {   from_version => $version_set->[$i],
                    to_version   => $version_set->[ $i + 1 ],
                    version_set =>
                        [ $version_set->[$i], $version_set->[ $i + 1 ] ]
                }
            );
        }
    }
    $self->deploy_handler->$direction;
}

sub ACTION_prepare_migration {
    my ($self) = @_;
    my $current_version = $self->_schema_version_in_db;
    my $new_version
        = $self->args('version')
        ? $self->args('version')
        : $self->schema->schema_version;

    my $version_set = $self->_version_set( $current_version, $new_version );
    my $tag = 'upgrade';
    if ( $current_version > $new_version ) {
        $tag = 'downgrade';
        $version_set = [ sort { $b <=> $a } @$version_set ];
    }
    if ( @$version_set == 2 ) {
        make_path(
            catdir(
                $self->args('migration_folder'),
                '_common', $tag, $version_set->[0] . '-' . $version_set->[1]
            ),
            catdir(
                $self->args('migration_folder'),
                '_preprocess_schema', $tag,
                $version_set->[0] . '-' . $version_set->[1]
            ),
        );
    }
    else {
        make_path(
            catdir(
                $self->args('migration_folder'),
                '_common', $tag,
                $version_set->[$_] . '-' . $version_set->[ $_ + 1 ]
            ),
            catdir(
                $self->args('migration_folder'),
                '_preprocess_schema', $tag,
                $version_set->[$_] . '-' . $version_set->[ $_ + 1 ]
            ),
        ) for 0 .. scalar @$version_set - 2;
    }
}

=item install_version()

Brings chado database under version control. Install chadoprop table for storing
version information. Both schema L<Bio::Chado::Schema> and chado versions are stored.

=cut

sub ACTION_install_version {
    my ($self) = @_;
    return if !$self->dbd;
    my $schema_class = $self->args('schema_class');
    my $schema       = $schema_class->connect(
        $self->args('dsn'), $self->args('user'),
        $self->args('password'),
        $self->dbi_driver eq 'Oracle'
        ? { LongReadLen => 2**25 }
        : {}
    );

    my $version
        = $self->args('version')
        ? $self->args('version')
        : $schema->schema_version;
    my $dh = Modware::Chado::Migration->new(
        {   schema           => $schema,
            schema_version   => $version,
            script_directory => $self->args('migration_folder'),
            databases        => $self->dbi_driver
        }
    );
    $dh->prepare_version_storage_install
        if !-e catfile( $self->args('migration_folder'),
        '_source', 'deploy', $version, '001-auto-__VERSION.yml' );
    $dh->install_version_storage;
    $dh->add_database_version(
        {   schema_version => $version,
            chado_version  => $self->args('chado_version')
        }
    );
}

sub ACTION_create_db {
}

sub ACTION_drop_db {
}

sub _chado_version_in_db {
    my ($self) = @_;
    my $vs = Modware::Chado::Migration::VersionStorage::Standard->new(
        { schema => $self->schema } );
    return $vs->database_version;
}

sub _schema_version_in_db {
    my ($self) = @_;
    my $vs = Modware::Chado::Migration::VersionStorage::Standard->new(
        { schema => $self->schema } );
    return $vs->version_rs->schema_version;
}

sub ACTION_chado_version_in_db {
    print $_[0]->_chado_version_in_db, "\n";
}

sub ACTION_schema_version_in_db {
    print $_[0]->_schema_version_in_db, "\n";
}

sub ACTION_add_patch {
    my ($self) = @_;
    my $arr = $self->args('ARGV');
    die "no patch name given\n" if !$arr->[0];
    my $patch = $arr->[0];

    my $folder = $self->_patch_folder;
    make_path $folder->stringify;

    # -- sorted files based on leading edge number
    my @sorted_num = sort { $b <=> $a }
        grep { looks_like_number($_) }
        map { ( basename( $_->stringify ) =~ /^(\d+)\S+$/ )[0] }
        grep { !$_->is_dir } Path::Class::Dir->new($folder)->children;

    my $patch_file;
    if (@sorted_num) {
        my $next_num = sprintf "%03d", $sorted_num[0] + 1;
        $patch_file = $folder->file( $next_num . $patch . '.pl' );
    }
    else {
        $patch_file = $folder->file( '001' . $patch . '.pl' );
    }
    my $output = $patch_file->openw;
    $output->print(<<'PATCH');
    ## -- patch script created by Modware::Chado::Migration module
    use strict;

    sub {
    	my ($dh, $dir, $logger, $release) = @_;
    	# - $dh: Modware::Chado::Migration deployment handler object
    	#       call $dh->schema to get Bio::Chado::Schema object
    	# ** make sure you use transaction for writing to database

    	# - $dir: A Path::Class::Dir object representing the data folder. 
    	# - $logger: A Log::Contextual::WarnLogger object.
    	# - $release: The release no under which the code is going to run.

    	## -- patch code below

    	my $schema = $dh->schema;
		# -- code below run under a transaction
    	my $guard = $schema->txn_scope_guard;

		
		$guard->commit;

    }
PATCH

    $output->close;
    warn "created patch ", $patch_file->stringify, "\n";
}

sub ACTION_run_all_patches {
    my ($self) = @_;
    for my $patch ( $self->_sorted_patch_files( $self->_patch_folder ) ) {
        $self->_run_patch_file($patch);
    }
}

sub ACTION_run_patch {
    my ($self) = @_;
    my $arr = $self->args('ARGV');
    die "no patch name given\n" if !$arr->[0];
    my $patch = $arr->[0];

    my $file = $self->_patch_folder->file($patch);
    die "file $patch do not exist\n" if !-e $file;
    $self->_run_patch_file($file);
}

sub ACTION_list_patches {
    my ($self) = @_;
    my $dir = $self->_patch_folder;
    if ( !-e $dir ) {
        warn "$dir do not exist\n";
        return;
    }

    warn "----- List of patches for release: ", $self->args('release'),
        " ----\n";
    for my $patch ( $self->_sorted_patch_files($dir) ) {
        warn "$patch\n";
    }
}

sub ACTION_set_release {
    my ($self) = @_;
    my $arr = $self->args('ARGV');
    die "no release no given\n" if !$arr->[0];
    $self->args( 'release', $arr->[0] );
}

sub _patch_folder {
    my ($self) = @_;
    $self->dbd    if !$self->dbi_driver;
    $self->_setup if !$self->deploy_handler;
    my $schema_ver = $self->_schema_version_in_db;
    if ( !$schema_ver ) {
        die "database is not under version control: patch cannot be run\n";
    }

    my $release = $self->_release;
    return Path::Class::Dir->new(
        catdir(
            $self->args('migration_folder'), '_common',
            'data_patch',                    $schema_ver,
            $release
        )
    );
}

sub _sorted_patch_files {
    my ( $self, $dir ) = @_;

    my @sorted_files = map { $_->[1] } sort { $a->[0] <=> $b->[0] }
        grep { looks_like_number( $_->[0] ) }
        map { [ ( basename( $_->stringify ) =~ /^(\d+)\S+$/ )[0], $_ ] }
        grep { !$_->is_dir && /\.pl$/ } $dir->children;

    return @sorted_files if @sorted_files;
}

sub _run_patch_file {
    my ( $self, $file ) = @_;
    my $content    = $file->slurp;
    my $subroutine = eval "$content";
    if ($@) {
        carp "Issue in loading code from ", $file->stringify, " :$@";
    }

    if ( reftype($subroutine) eq 'CODE' ) {
        $self->_run_code( $file, $subroutine );
    }
    else {
        warn "got ", reftype $subroutine, " from the $file\n";
        warn "expecting coderef from ", $file->stringify,
            "  that is not defined\n";
        warn "create a stub patch script file by running ./Build add_patch\n";
    }
}

sub _run_code {
    my ( $self, $file, $coderef ) = @_;
    $self->logger->info( ' .. running coderef from ' . $file->stringify );
    $self->logger->info('     ....................................... ');
    $self->dbd;
    $self->_setup if !$self->deploy_handler;
    eval {
        $coderef->(
            $self->deploy_handler,
            Path::Class::Dir->new( $self->args('data_dir') ),
            $self->logger, 
            $self->args('release')
        );
        $self->logger->info( ' .. done running ' . $file->stringify );
        $self->logger->info('     ....................................... ');
    };
    if ($@) {
        $self->logger->error("Unable to run code $@");
        die;
    }
}

sub _release {
    my ($self) = @_;
    return $self->args('release') if $self->args('release');

    my $release = $self->prompt('[Enter release no]:');
    die "need a release no for patch commands\n" if !$release;
    $self->args( 'release', $release );
    return $release;
}

sub _setup {
    my ($self) = @_;
    my $schema_class = $self->args('schema_class');
    my $attrs
        = $self->dbi_driver eq 'Oracle' ? { 'LongReadLen' => 2**25 } : {};
    my $schema = $schema_class->connect(
        $self->args('dsn'),
        $self->args('user'),
        $self->args('password'),
        $attrs,
        {   on_connect_do => sub {
                my ($dbi) = @_;
                tie %{ $dbi->_dbh->{CachedKids} }, 'Tie::Cache', 50;
                }
        }
    );
    my $dh = Modware::Chado::Migration->new(
        {   schema              => $schema,
            databases           => $self->dbi_driver,
            script_directory    => $self->args('migration_folder'),
            sql_translator_args => {
                filters        => [ sub { $self->_clean_phylonode(@_) } ],
                add_drop_table => 0
            },
            builder => $self
        }
    );
    $self->schema($schema);
    $self->deploy_handler($dh);
}

sub dbd {
    my ($self) = @_;
    if ( $self->args('dsn') ) {
        my ( $schema, $driver ) = DBI->parse_dsn( $self->args('dsn') );
        $driver = 'PostgreSQL' if $driver eq 'Pg';
        $self->dbi_driver($driver);
        return $driver;
    }
    else {
        die "value for --dsn argument is missing\n";
    }
}

sub _version_set {
    my ( $self, $current_version, $new_version ) = @_;

    my @version_dirs = File::Find::Rule->directory->in(
        catdir(
            $self->args('migration_folder'), $self->dbi_driver, 'deploy'
        )
    );

    my $version_set;
    if ( $current_version < $new_version ) {
        $version_set = [
            grep { $_ >= $current_version and $_ <= $new_version }
                map { ( ( split /\//, $version_dirs[$_] ) )[-1] }
                1 .. $#version_dirs
        ];
    }
    else {
        $version_set = [
            grep { $_ <= $current_version and $_ >= $new_version }
                map { ( ( split /\//, $version_dirs[$_] ) )[-1] }
                1 .. $#version_dirs
        ];
    }
    return $version_set;
}

sub _clean_phylonode {
    my ( $self, $schema ) = @_;
    my $table = $schema->get_table('phylonode');
    return if !$table;
    for my $cons ( grep { $_->name eq 'phylonode_fk_phylotree_id' }
        @{ $table->fkey_constraints } )
    {
        $table->drop_constraint($cons)
            if $cons->reference_table eq 'phylonode';
        last;
    }
}

before [qw/_setup ACTION_install_version ACTION_migrate/] => sub {
    my ($self) = @_;
    my $schema_class = $self->args('schema_class');
    Class::MOP->load_class($schema_class)
        if !Class::Inspector->loaded($schema_class);
};

before [qw/ACTION_init _chado_version_in_db _schema_version_in_db/] => sub {
    my ($self) = @_;
    $self->dbd;
    $self->_setup;
};

__PACKAGE__->meta->make_immutable( inline_constructor => 0 );

1;    # Magic true value required at end of module

__END__

=head1 NAME

B<Modware::Chado::Migration::Build> - [Chado database versioning tool]

=head1 ACTION

=over

=back

=head1 AUTHOR

I<Siddhartha Basu>  B<siddhartha-basu@northwestern.edu>

=head1 LICENCE AND COPYRIGHT

Copyright (c) B<2003>, Siddhartha Basu C<<siddhartha-basu@northwestern.edu>>. All rights reserved.

This module is free software; you can redistribute it and/
or modify it under the same terms as Perl itself
. See L <perlartistic>



