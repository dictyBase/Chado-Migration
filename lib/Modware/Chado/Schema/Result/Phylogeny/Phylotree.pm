
package Modware::Chado::Schema::Result::Phylogeny::Phylotree;

use strict;
use parent qw/Bio::Chado::Schema::Result::Phylogeny::Phylotree/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

