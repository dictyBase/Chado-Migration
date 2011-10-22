
package Modware::Chado::Schema::Result::Pub::Pub;

use strict;
use parent qw/Bio::Chado::Schema::Result::Pub::Pub/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

