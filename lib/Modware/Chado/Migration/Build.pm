package Modware::Chado::Migration::Build;

use warnings;
use strict;
use namespace::autoclean;
use Moose;
use File::Spec::Functions;
use Modware::Chado::Migration::VersionStorage::Standard;
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

extends 'Module::Build';

# Module implementation
#
__PACKAGE__->add_property('dbi_driver');
__PACKAGE__->add_property('schema');
__PACKAGE__->add_property('deploy_handler');
__PACKAGE__->add_property('bcs_base');
__PACKAGE__->add_property('schema_version');

sub ACTION_init_from_scratch {
    my ($self) = @_;

    my $schema_class = $self->args('schema_class');
    ## -- set it to Bio::Chado::Schema for generating sql
    $self->args( 'schema_class' => 'Bio::Chado::Schema' );

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

sub ACTION_install_version {
    my ($self) = @_;
    return if !$self->dbd;
    my $schema_class = $self->args('schema_class');
    my $schema
        = $schema_class->connect( $self->args('dsn'), $self->args('user'),
        $self->args('password') );

    my $version
        = $self->args('version')
        ? $self->args('version')
        : $schema->schema_version;
    my $dh = Modware::Chado::Migration->new(
        {   schema           => $schema,
            ordered_versions => [ $version, $version ],
            force_overwrite  => 1
        }
    );
    $dh->prepare_version_storage_install;
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

sub _setup {
    my ($self) = @_;
    my $schema_class = $self->args('schema_class');
    my $schema
        = $schema_class->connect( $self->args('dsn'), $self->args('user'),
        $self->args('password') );
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

        <MODULE NAME> - [One line description of module's purpose here]

        =head1 VERSION

        This document describes <MODULE NAME> version 0.0.1

        =head1 SYNOPSIS

        use <MODULE NAME>;

        =for author to fill in:
        Brief code example(s) here showing commonest usage(s).
        This section will be as far as many users bother reading
        so make it as educational and exeplary as possible.

        =head1 DESCRIPTION

        =for author to fill in:
        Write a full description of the module and its features here.
        Use subsections (=head2, =head3) as appropriate.

        =head1 INTERFACE

        =for author to fill in:
        Write a separate section listing the public components of the modules
        interface. These normally consist of either subroutines that may be
        exported, or methods that may be called on objects belonging to the
        classes provided by the module.

        =head2 <METHOD NAME>

        =over

        =item B<Use:> <Usage>

        [Detail text here]

        =item B<Functions:> [What id does]

        [Details if neccessary]

        =item B<Return:> [Return type of value]

        [Details]

        =item B<Args:> [Arguments passed]

        [Details]

        =back

        =head2 <METHOD NAME>

        =over

        =item B<Use:> <Usage>

        [Detail text here]

        =item B<Functions:> [What id does]

        [Details if neccessary]

        =item B<Return:> [Return type of value]

        [Details]

        =item B<Args:> [Arguments passed]

        [Details]

        =back

        =head1 DIAGNOSTICS

        =for author to fill in:
        List every single error and warning message that the module can
        generate (even the ones that will "never happen"), with a full
        explanation of each problem, one or more likely causes, and any
        suggested remedies.

        =over

        =item C<< Error message here, perhaps with %s placeholders >>

        [Description of error here]

        =item C<< Another error message here >>

        [Description of error here]

        [Et cetera, et cetera]

        =back

        =head1 CONFIGURATION AND ENVIRONMENT

        =for author to fill in:
        A full explanation of any configuration system(s) used by the
        module, including the names and locations of any configuration
        files, and the meaning of any environment variables or properties
        that can be set. These descriptions must also include details of any
        configuration language used.

        <MODULE NAME> requires no configuration files or environment variables.

        =head1 DEPENDENCIES

        =for author to fill in:
        A list of all the other modules that this module relies upon,
        including any restrictions on versions, and an indication whether
        the module is part of the standard Perl distribution, part of the
        module's distribution, or must be installed separately. ]

        None.

        =head1 INCOMPATIBILITIES

        =for author to fill in:
        A list of any modules that this module cannot be used in conjunction
        with. This may be due to name conflicts in the interface, or
        competition for system or program resources, or due to internal
        limitations of Perl (for example, many modules that use source code
        filters are mutually incompatible).

        None reported.

        =head1 BUGS AND LIMITATIONS

        =for author to fill in:
        A list of known problems with the module, together with some
        indication Whether they are likely to be fixed in an upcoming
        release. Also a list of restrictions on the features the module
        does provide: data types that cannot be handled, performance issues
        and the circumstances in which they may arise, practical
        limitations on the size of data sets, special cases that are not
        (yet) handled, etc.

        No bugs have been reported.Please report any bugs or feature requests to
        dictybase@northwestern.edu

        =head1 TODO

        =over

        =item *

        [Write stuff here]

        =item *

        [Write stuff here]

        =back

        =head1 AUTHOR

        I<Siddhartha Basu>  B<siddhartha-basu@northwestern.edu>

       =head1 LICENCE AND COPYRIGHT

        Copyright (c) B<2003>, Siddhartha Basu C<<siddhartha-basu@northwestern.edu>>. All rights reserved.

        This module is free software; you can redistribute it and/
        or modify it under the same terms as Perl itself
        . See L <perlartistic>
        .

        = head1 DISCLAIMER OF WARRANTY

        BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
        FOR THE SOFTWARE,
    TO THE EXTENT PERMITTED BY APPLICABLE LAW . EXCEPT WHEN
        OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND
        / OR OTHER PARTIES
        PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
        EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
        WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
        . THE
        ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
        YOU 
        . SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
        NECESSARY SERVICING, REPAIR, OR CORRECTION
        .

        IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
        WILL ANY COPYRIGHT HOLDER,
    OR ANY OTHER PARTY WHO MAY MODIFY AND
        / OR REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE,
    BE LIABLE TO YOU FOR DAMAGES,
    INCLUDING ANY GENERAL,
    SPECIAL,
    INCIDENTAL,
    OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE
        SOFTWARE(
        INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED
            INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
            FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE
        ),
    EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
        SUCH DAMAGES
        .

