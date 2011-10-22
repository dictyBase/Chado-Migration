
package Modware::Chado::Schema::Result::Expression::FeatureExpressionprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Expression::FeatureExpressionprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

