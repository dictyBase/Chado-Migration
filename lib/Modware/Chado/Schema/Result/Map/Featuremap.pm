
package Modware::Chado::Schema::Result::Map::Featuremap;

use strict;
use parent qw/Bio::Chado::Schema::Result::Map::Featuremap/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

