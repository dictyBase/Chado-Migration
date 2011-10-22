
package Modware::Chado::Schema::Result::Mage::Studyfactorvalue;

use strict;
use parent qw/Bio::Chado::Schema::Result::Mage::Studyfactorvalue/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

