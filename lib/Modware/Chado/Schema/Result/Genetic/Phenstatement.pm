
package Modware::Chado::Schema::Result::Genetic::Phenstatement;

use strict;
use parent qw/Bio::Chado::Schema::Result::Genetic::Phenstatement/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

