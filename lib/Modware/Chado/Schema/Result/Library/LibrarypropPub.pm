
package Modware::Chado::Schema::Result::Library::LibrarypropPub;

use strict;
use parent qw/Bio::Chado::Schema::Result::Library::LibrarypropPub/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

