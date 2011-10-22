
package Modware::Chado::Schema::Result::Library::LibraryDbxref;

use strict;
use parent qw/Bio::Chado::Schema::Result::Library::LibraryDbxref/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

