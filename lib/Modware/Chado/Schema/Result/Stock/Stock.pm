
package Modware::Chado::Schema::Result::Stock::Stock;

use strict;
use parent qw/Bio::Chado::Schema::Result::Stock::Stock/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

