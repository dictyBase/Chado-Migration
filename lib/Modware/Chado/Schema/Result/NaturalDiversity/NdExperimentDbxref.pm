
package Modware::Chado::Schema::Result::NaturalDiversity::NdExperimentDbxref;

use strict;
use parent qw/Bio::Chado::Schema::Result::NaturalDiversity::NdExperimentDbxref/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

