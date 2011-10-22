
package Modware::Chado::Schema::Result::Mage::Arraydesignprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Arraydesignprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

