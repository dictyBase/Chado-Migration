
package Modware::Chado::Schema::Result::Composite::FeatureDifference;

use strict;
use parent qw/Bio::Chado::Schema::Result::Composite::FeatureDifference/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

