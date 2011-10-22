
package Modware::Chado::Schema::Result::Companalysis::Analysisfeature;

use strict;
use parent qw/Bio::Chado::Schema::Result::Companalysis::Analysisfeature/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

