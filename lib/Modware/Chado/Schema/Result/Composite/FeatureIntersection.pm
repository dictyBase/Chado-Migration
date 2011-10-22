
package Modware::Chado::Schema::Result::Composite::FeatureIntersection;

use strict;
use parent qw/Bio::Chado::Schema::Result::Composite::FeatureIntersection/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

