
package Modware::Chado::Schema::Result::Phylogeny::Phylonode;

use strict;
use parent qw/Bio::Chado::Schema::Result::Phylogeny::Phylonode/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

