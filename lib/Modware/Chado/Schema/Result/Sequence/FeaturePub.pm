
package Modware::Chado::Schema::Result::Sequence::FeaturePub;

use strict;
use parent qw/Bio::Chado::Schema::Result::Sequence::FeaturePub/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

