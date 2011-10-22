
package Modware::Chado::Schema::Result::CellLine::CellLineCvterm;

use strict;
use parent qw/Bio::Chado::Schema::Result::CellLine::CellLineCvterm/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

