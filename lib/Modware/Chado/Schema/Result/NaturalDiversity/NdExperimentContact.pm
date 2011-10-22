
package Modware::Chado::Schema::Result::NaturalDiversity::NdExperimentContact;

use strict;
use parent qw/Bio::Chado::Schema::Result::NaturalDiversity::NdExperimentContact/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

