
package Modware::Chado::Schema::Result::Stock::StockpropPub;

use strict;
use parent qw/Bio::Chado::Schema::Result::Stock::StockpropPub/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

