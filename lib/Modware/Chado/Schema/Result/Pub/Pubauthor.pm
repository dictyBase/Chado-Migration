
package Modware::Chado::Schema::Result::Pub::Pubauthor;

use strict;
use parent qw/Bio::Chado::Schema::Result::Pub::Pubauthor/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

