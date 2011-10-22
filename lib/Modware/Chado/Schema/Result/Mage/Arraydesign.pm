
package Modware::Chado::Schema::Result::Mage::Arraydesign;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Arraydesign/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

