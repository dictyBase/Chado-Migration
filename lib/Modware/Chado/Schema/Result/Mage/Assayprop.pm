
package Modware::Chado::Schema::Result::Mage::Assayprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Assayprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

