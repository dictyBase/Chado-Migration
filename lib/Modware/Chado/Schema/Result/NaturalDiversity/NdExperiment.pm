
package Modware::Chado::Schema::Result::NaturalDiversity::NdExperiment;

use strict;
use parent qw/Bio::Chado::Schema::Result::NaturalDiversity::NdExperiment/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

