
package Modware::Chado::Schema::Result::Mage::AssayBiomaterial;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::AssayBiomaterial/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

