
package Modware::Chado::Schema::Result::Composite::FeatureUnion;

use strict;
use parent qw/Bio::Chado::Schema::Result::Composite::FeatureUnion/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

