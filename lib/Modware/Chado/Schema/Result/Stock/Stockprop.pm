
package Modware::Chado::Schema::Result::Stock::Stockprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Stock::Stockprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

