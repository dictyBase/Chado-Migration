
package Modware::Chado::Schema::Result::Companalysis::Analysisfeatureprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Companalysis::Analysisfeatureprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

