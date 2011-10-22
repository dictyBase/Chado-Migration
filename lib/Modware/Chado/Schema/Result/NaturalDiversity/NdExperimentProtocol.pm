
package Modware::Chado::Schema::Result::NaturalDiversity::NdExperimentProtocol;

use strict;
use parent qw/Bio::Chado::Schema::Result::NaturalDiversity::NdExperimentProtocol/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

