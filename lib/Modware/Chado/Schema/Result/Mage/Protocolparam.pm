
package Modware::Chado::Schema::Result::Mage::Protocolparam;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Protocolparam/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

