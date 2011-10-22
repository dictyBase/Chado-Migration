
package Modware::Chado::Schema::Result::CellLine::CellLinePub;

use strict;
use parent qw/Bio::Chado::Schema::Result::CellLine::CellLinePub/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

