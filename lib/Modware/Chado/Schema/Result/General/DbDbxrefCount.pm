
package Modware::Chado::Schema::Result::General::DbDbxrefCount;

use strict;
use parent qw/Bio::Chado::Schema::Result::General::DbDbxrefCount/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

