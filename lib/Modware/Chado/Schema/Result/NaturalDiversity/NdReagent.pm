
package Modware::Chado::Schema::Result::NaturalDiversity::NdReagent;

use strict;
use parent qw/Bio::Chado::Schema::Result::NaturalDiversity::NdReagent/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

