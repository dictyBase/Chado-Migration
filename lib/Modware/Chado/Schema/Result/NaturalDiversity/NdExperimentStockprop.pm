
package Modware::Chado::Schema::Result::NaturalDiversity::NdExperimentStockprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::NaturalDiversity::NdExperimentStockprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

