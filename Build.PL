use strict;
use warnings;
use DBI;
use File::Spec::Functions;
use File::Path qw/make_path/;
use lib 'lib';
use Modware::Chado::Migration::Build;

my %module_build_args = (
    'build_requires' => { 'Module::Build' => '0.3601' },
    'dist_abstract'  => 'Module for chado database migration',
    'dist_author'  => ['Siddhartha Basu <siddhartha-basu@northwestern.edu>'],
    'dist_name'    => 'Modware-Chado-Migration',
    'dist_version' => '0.0010',
    'license'      => 'perl',
    'module_name'  => 'Modware::Chado::Migration',
    'recommends'   => {
        'DBD::SQLite'      => '1.33',
        'App::pmuninstall' => '0.24',
        'Carton'           => '',
        'Bio::Root::RootI' => '1.006901',
        'DBD::Oracle'      => '1.27', 
        'Math::BigInt' => '1.99', 
        'Math::Base36' => '0.09'
    },
    'recursive_test_files' => 1,
    'build_requires'       => {
        'DBIx::Class'                    => '0.08127',
        'DBIx::Class::DeploymentHandler' => '0.001005',
        'HTTP::Tiny'                     => '0.013',
        'IPC::Cmd'                       => '0.46',
        'JSON'                           => '2.53',
        'Class::Inspector'               => '1.25',
        'Class::Unload'                  => '0.07',
        'App::cpanminus'                 => '1.4008',
        'Bio::Chado::Schema'             => '0.09000',
        'Path::Class'                    => '0.24',
        'local::lib'                     => '1.008004',
        'Tie::Cache'                     => '',
        'Time::Piece'                    => '1.20'
    },
    'script_files' => [],
    get_options    => {
        dsn              => { type => ':s' },
        user             => { type => ':s' },
        password         => { type => ':s' },
        version          => { type => ':f' },
        migration_folder => { type => ':s' },
        release          => { type => ':s' },
        data_dir         => { type => ':s' },
        schema_class => { type => ':s', default => 'Modware::Chado::Schema' },
        chado_version => { type => ':f', default => 1.2 }
    }
);

my $build = Modware::Chado::Migration::Build->new(%module_build_args);
if ( !$build->args('migration_folder') ) {
    $build->args( 'migration_folder', catdir( $build->base_dir, 'db' ) );
}
if ( !$build->args('data_dir') ) {
    my $dir = catdir( $build->base_dir, 'data' );
    make_path $dir;
    $build->args( 'data_dir', $dir );
}
$build->create_build_script;
