
package Modware::Chado::Schema::Result::Phylogeny::Phylonodeprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Phylogeny::Phylonodeprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

