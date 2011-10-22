
package Modware::Chado::Schema::Result::CellLine::CellLineSynonym;

use strict;
use parent qw/Bio::Chado::Schema::Result::CellLine::CellLineSynonym/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

