
package Modware::Chado::Schema::Result::Organism::Organismprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Organism::Organismprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

