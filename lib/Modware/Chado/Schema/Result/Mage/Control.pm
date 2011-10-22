
package Modware::Chado::Schema::Result::Mage::Control;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Control/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

