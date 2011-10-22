
package Modware::Chado::Schema::Result::NaturalDiversity::NdExperimentPub;

use strict;
use parent qw/Bio::Chado::Schema::Result::NaturalDiversity::NdExperimentPub/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

