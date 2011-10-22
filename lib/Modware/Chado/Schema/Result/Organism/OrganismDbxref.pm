
package Modware::Chado::Schema::Result::Organism::OrganismDbxref;

use strict;
use parent qw/Bio::Chado::Schema::Result::Organism::OrganismDbxref/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

