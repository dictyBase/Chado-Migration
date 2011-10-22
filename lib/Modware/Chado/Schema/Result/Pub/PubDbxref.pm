
package Modware::Chado::Schema::Result::Pub::PubDbxref;

use strict;
use parent qw/Bio::Chado::Schema::Result::Pub::PubDbxref/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

