
package Modware::Chado::Schema::Result::Composite::FnrType;

use strict;
use parent qw/Bio::Chado::Schema::Result::Composite::FnrType/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

