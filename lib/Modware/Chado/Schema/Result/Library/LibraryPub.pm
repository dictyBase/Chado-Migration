
package Modware::Chado::Schema::Result::Library::LibraryPub;

use strict;
use parent qw/Bio::Chado::Schema::Result::Library::LibraryPub/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

