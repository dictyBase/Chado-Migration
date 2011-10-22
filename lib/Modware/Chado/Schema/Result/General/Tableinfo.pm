
package Modware::Chado::Schema::Result::General::Tableinfo;

use strict;
use parent qw/Bio::Chado::Schema::Result::General::Tableinfo/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

