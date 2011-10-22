
package Modware::Chado::Schema::Result::Expression::FeatureExpression;

use strict;
use parent qw/Bio::Chado::Schema::Result::Expression::FeatureExpression/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

