
package Modware::Chado::Schema::Result::Genetic::Phendesc;

use strict;
use parent qw/Bio::Chado::Schema::Result::Genetic::Phendesc/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

