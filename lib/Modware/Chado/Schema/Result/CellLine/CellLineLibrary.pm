
package Modware::Chado::Schema::Result::CellLine::CellLineLibrary;

use strict;
use parent qw/Bio::Chado::Schema::Result::CellLine::CellLineLibrary/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

