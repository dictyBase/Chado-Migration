
package Modware::Chado::Schema::Result::Pub::Pubprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Pub::Pubprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

