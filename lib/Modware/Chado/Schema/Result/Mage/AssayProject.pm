
package Modware::Chado::Schema::Result::Mage::AssayProject;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::AssayProject/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

