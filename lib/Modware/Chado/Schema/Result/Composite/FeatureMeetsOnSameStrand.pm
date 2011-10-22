
package Modware::Chado::Schema::Result::Composite::FeatureMeetsOnSameStrand;

use strict;
use parent qw/Bio::Chado::Schema::Result::Composite::FeatureMeetsOnSameStrand/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

