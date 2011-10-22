
package Modware::Chado::Schema::Result::Phylogeny::PhylonodePub;

use strict;
use parent qw/Bio::Chado::Schema::Result::Phylogeny::PhylonodePub/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

