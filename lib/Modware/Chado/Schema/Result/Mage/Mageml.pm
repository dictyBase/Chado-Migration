
package Modware::Chado::Schema::Result::Mage::Mageml;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Mageml/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

