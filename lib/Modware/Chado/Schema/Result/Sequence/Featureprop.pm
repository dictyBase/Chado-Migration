
package Modware::Chado::Schema::Result::Sequence::Featureprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Sequence::Featureprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

