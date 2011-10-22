
package Modware::Chado::Schema::Result::General::Dbxref;

use strict;
use parent qw/Bio::Chado::Schema::Result::General::Dbxref/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

