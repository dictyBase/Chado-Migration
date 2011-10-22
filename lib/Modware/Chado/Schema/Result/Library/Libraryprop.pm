
package Modware::Chado::Schema::Result::Library::Libraryprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Library::Libraryprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

