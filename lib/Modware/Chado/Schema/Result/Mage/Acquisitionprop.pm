
package Modware::Chado::Schema::Result::Mage::Acquisitionprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Acquisitionprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

