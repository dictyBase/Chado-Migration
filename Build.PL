use strict;
use warnings;
use DBI;
use File::Spec::Functions;
use lib 'lib';
use Modware::Chado::Migration::Build;

my %module_build_args = (
    'build_requires' => { 'Module::Build' => '0.3601' },
    'dist_abstract'        => 'Module for dictybase chado database migration',
    'dist_author'          => ['Siddhartha Basu <biosidd@gmail.com>'],
    'dist_name'            => 'Dicty-Migration',
    'dist_version'         => '0.0010',
    'license'              => 'perl',
    'module_name'          => 'Dicty::Migration',
    'recommends'           => {},
    'recursive_test_files' => 1,
    'requires'             => { 'DBIx::Class::DeploymentHandler' => '' },
    'script_files'         => [],
    get_options            => {
        dsn              => { type => ':s' },
        user             => { type => ':s' },
        password         => { type => ':s' },
        version          => { type => ':f' },
        migration_folder => { type => ':s' },
        schema_class     => { type => ':s', default => 'Modware::Chado::Schema' },
        chado_version    => { type => ':f',  default => 1.2 }
    }
);

my $build = Modware::Chado::Migration::Build->new(%module_build_args);
if ( !$build->args('migration_folder') ) {
    $build->args( 'migration_folder', catdir( $build->base_dir, 'db' ) );
}
$build->create_build_script;
