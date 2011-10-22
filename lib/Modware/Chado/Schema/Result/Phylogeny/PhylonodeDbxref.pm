
package Modware::Chado::Schema::Result::Phylogeny::PhylonodeDbxref;

use strict;
use parent qw/Bio::Chado::Schema::Result::Phylogeny::PhylonodeDbxref/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

