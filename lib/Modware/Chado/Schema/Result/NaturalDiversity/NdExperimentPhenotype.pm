
package Modware::Chado::Schema::Result::NaturalDiversity::NdExperimentPhenotype;

use strict;
use parent qw/Bio::Chado::Schema::Result::NaturalDiversity::NdExperimentPhenotype/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

