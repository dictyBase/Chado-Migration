
package Modware::Chado::Schema::Result::Mage::Element;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Element/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

