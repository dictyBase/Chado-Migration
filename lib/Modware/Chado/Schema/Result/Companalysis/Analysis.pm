
package Modware::Chado::Schema::Result::Companalysis::Analysis;

use strict;
use parent qw/Bio::Chado::Schema::Result::Companalysis::Analysis/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

