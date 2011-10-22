
package Modware::Chado::Schema::Result::Mage::Assay;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Assay/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

