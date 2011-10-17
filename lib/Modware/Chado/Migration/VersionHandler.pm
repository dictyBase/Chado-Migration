package Modware::Chado::Migration::VersionHandler;

use Carp 'croak';
use Moose;
use Moose::Util::TypeConstraints;

# ABSTRACT: Define your own list of versions to use for migrations

with 'DBIx::Class::DeploymentHandler::HandlesVersioning';

subtype 'VersionSet', => as 'ArrayRef[Num]',
    => where { scalar @$_ >= 2 },
    => message {"Need at least two versions in the version set"};

has schema_version => (
    isa => 'Str',
    is  => 'rw',
);

has database_version => (
    isa => 'Str',
    is  => 'rw',
);

has to_version => (
    is         => 'rw',
    isa        => 'Str',
    lazy_build => 1,
);

sub _build_to_version { $_[0]->schema_version }

has version_set => (
    is      => 'rw',
    isa     => 'VersionSet',
    traits  => [qw/Array/],
    handles => {
        'version_set_count' => 'count',
        'sort_versions'     => 'sort'
    },
    trigger => sub {
        my ( $self, $set ) = @_;
        $self->_idx_end( $#$set - 1 );
    }
);

has _idx_end => (
    is  => 'rw',
    isa => 'Int'
);

has _version_idx => (
    traits  => [qw/Counter/],
    is      => 'rw',
    isa     => 'Num',
    default => -1,
    lazy    => 1,
    handles => { incr_version_idx => 'inc', }
);

sub next_version_set {
    my ($self) = @_;

    my $version_set = [ $self->sort_versions( sub { $_[0] <=> $_[1] } ) ];

    if ( $self->version_set_count == 2 ) {
        return if $self->_version_idx == 0;
    	$self->validate_next_version_set( 0, $version_set );
        $self->incr_version_idx;
        return $version_set;
    }

    # -- no more iteration
    return if $self->_version_idx == $self->_idx_end;
    $self->incr_version_idx;
    my $idx = $self->_version_idx;
    $self->validate_next_version_set( $idx, $version_set );
    return [ $version_set->[$idx], $version_set->[ $idx + 1 ] ];
}

sub previous_version_set {
    my ($self) = @_;

    my $version_set = [ $self->sort_versions( sub { $_[1] <=> $_[0] } ) ];

    if ( $self->version_set_count == 2 ) {
        return if $self->_version_idx == 0;
    	$self->validate_prev_version_set( 0, $version_set );
        $self->incr_version_idx;
        return $version_set;
    }

    # -- no more iteration
    return if $self->_version_idx == $self->_idx_end;
    $self->incr_version_idx;
    my $idx = $self->_version_idx;
    $self->validate_prev_version_set( $idx, $version_set );
    return [ $version_set->[$idx], $version_set->[ $idx + 1 ] ];
}

sub validate_next_version_set {
    my ( $self, $index, $version_set ) = @_;
    my $curr = $version_set->[$index];
    my $next = $version_set->[ $index + 1 ];
    if ( $curr >= $next ) {
        croak
            "next $next version should be greater than current $curr version\n";
    }
}

sub validate_prev_version_set {
    my ( $self, $index, $version_set ) = @_;
    my $curr = $version_set->[$index];
    my $next = $version_set->[ $index + 1 ];
    if ( $curr <= $next ) {
        croak
            "next $next version should be less than current $curr version\n";
    }
}

__PACKAGE__->meta->make_immutable;

1;

=pod

=head1 NAME

Modware::Chado::Migration::VersionHandler - Version handler to use for chado migrations

__END__

