
package Modware::Chado::Schema::Result::Sequence::TypeFeatureCount;

use strict;
use parent qw/Bio::Chado::Schema::Result::Sequence::TypeFeatureCount/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

