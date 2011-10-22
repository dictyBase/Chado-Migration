
package Modware::Chado::Schema::Result::Companalysis::Analysisprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Companalysis::Analysisprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

