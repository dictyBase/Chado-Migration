
package Modware::Chado::Schema::Result::Library::LibraryCvterm;

use strict;
use parent qw/Bio::Chado::Schema::Result::Library::LibraryCvterm/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

