
package Modware::Chado::Schema::Result::Expression::ExpressionCvterm;

use strict;
use parent qw/Bio::Chado::Schema::Result::Expression::ExpressionCvterm/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

