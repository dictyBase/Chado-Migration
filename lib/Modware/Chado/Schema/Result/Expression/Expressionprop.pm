
package Modware::Chado::Schema::Result::Expression::Expressionprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Expression::Expressionprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

