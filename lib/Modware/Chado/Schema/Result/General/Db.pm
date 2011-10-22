
package Modware::Chado::Schema::Result::General::Db;

use strict;
use parent qw/Bio::Chado::Schema::Result::General::Db/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

