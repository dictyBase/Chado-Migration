
package Modware::Chado::Schema::Result::Mage::Acquisition;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Acquisition/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

