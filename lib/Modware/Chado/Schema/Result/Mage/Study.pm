
package Modware::Chado::Schema::Result::Mage::Study;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Study/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

