
package Modware::Chado::Schema::Result::Library::LibrarySynonym;

use strict;
use parent qw/Bio::Chado::Schema::Result::Library::LibrarySynonym/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

