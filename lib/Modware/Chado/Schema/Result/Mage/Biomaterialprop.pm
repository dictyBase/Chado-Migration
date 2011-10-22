
package Modware::Chado::Schema::Result::Mage::Biomaterialprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Biomaterialprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

