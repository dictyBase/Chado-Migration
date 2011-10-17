package Modware::Chado::Migration;

use Moose;
use DBIx::Class::DeploymentHandler::Logger;
use Log::Contextual ':log', -package_logger =>
    DBIx::Class::DeploymentHandler::Logger->new( { env_prefix => 'DBICDH' } );
use namespace::autoclean;
extends 'DBIx::Class::DeploymentHandler::Dad';

# a single with would be better, but we can't do that
# see: http://rt.cpan.org/Public/Bug/Display.html?id=46347
with 'DBIx::Class::DeploymentHandler::WithApplicatorDumple' => {
    interface_role => 'DBIx::Class::DeploymentHandler::HandlesDeploy',
    class_name =>
        'DBIx::Class::DeploymentHandler::DeployMethod::SQL::Translator',
    delegate_name        => 'deploy_method',
    attributes_to_assume => [qw(schema schema_version)],
    attributes_to_copy   => [
        qw(
            ignore_ddl databases script_directory sql_translator_args force_overwrite
            )
    ],
    },
    'DBIx::Class::DeploymentHandler::WithApplicatorDumple' => {
    interface_role => 'DBIx::Class::DeploymentHandler::HandlesVersioning',
    class_name =>
        'Modware::Chado::Migration::VersionHandler',
    delegate_name        => 'version_handler',
    attributes_to_copy   => [qw/version_set _idx_end/],
    attributes_to_assume => [qw( database_version schema_version to_version)],
    },
    'DBIx::Class::DeploymentHandler::WithApplicatorDumple' => {
    interface_role => 'DBIx::Class::DeploymentHandler::HandlesVersionStorage',
    class_name     => 'Modware::Chado::Migration::VersionStorage::Standard',
    delegate_name  => 'version_storage',
    attributes_to_assume => ['schema'],
    };
with 'DBIx::Class::DeploymentHandler::WithReasonableDefaults';

has 'builder' => ( isa => 'Module::Build', is => 'rw' );

sub prepare_version_storage_install {
    my $self = shift;

    $self->prepare_resultsource_install(
        {   result_source => $self->version_storage->version_rs->result_source
        }
    );
}

sub install_version_storage {
    my $self = shift;

    my $version = ( shift || {} )->{version} || $self->schema_version;

    $self->install_resultsource(
        {   result_source =>
                $self->version_storage->version_rs->result_source,
            version => $version,
        }
    );
}

sub prepare_install {
    $_[0]->prepare_deploy;
    $_[0]->prepare_version_storage_install;
}

override 'downgrade' => sub {
    log_info {'downgrading'};
    my ($self) = @_;
    my $ran_once = 0;
    while ( my $version_list = $self->previous_version_set ) {
        $ran_once = 1;
        $self->downgrade_single_step( { version_set => $version_list } );

        $self->add_database_version(
            {   schema_version       => $version_list->[-1],
                chado_version => $self->builder->args('chado_version'),
            }
        );
    }
    log_warn {'no version to run downgrade'} unless $ran_once;
};

override 'upgrade' => sub {
    log_info {'upgrading'};
    my ($self) = @_;
    my $ran_once = 0;
    while ( my $version_list = $self->next_version_set ) {
        $ran_once = 1;
        my ( $ddl, $upgrade_sql )
            = @{ $self->upgrade_single_step(
                { version_set => $version_list } )
                || [] };

        $self->add_database_version(
            {   schema_version       => $version_list->[-1],
                chado_version => $self->builder->args('chado_version')
            }
        );
    }
    log_warn {'no need to run upgrade'} unless $ran_once;
};

# the following is just a hack so that ->version_storage
# won't be lazy
sub BUILD { $_[0]->version_storage }
__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Dicty::Migration -

=head1 SYNOPSIS

  use Dicty::Migration;

=head1 DESCRIPTION

Dicty::Migration is

=head1 AUTHOR

Siddhartha Basu E<lt>siddhartha-basu@northwestern.eduE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
