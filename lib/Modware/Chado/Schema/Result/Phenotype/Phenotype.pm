
package Modware::Chado::Schema::Result::Phenotype::Phenotype;

use strict;
use parent qw/Bio::Chado::Schema::Result::Phenotype::Phenotype/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

