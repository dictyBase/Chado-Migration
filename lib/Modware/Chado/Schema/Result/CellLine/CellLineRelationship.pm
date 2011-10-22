
package Modware::Chado::Schema::Result::CellLine::CellLineRelationship;

use strict;
use parent qw/Bio::Chado::Schema::Result::CellLine::CellLineRelationship/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

