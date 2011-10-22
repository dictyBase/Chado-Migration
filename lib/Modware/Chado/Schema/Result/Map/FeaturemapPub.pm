
package Modware::Chado::Schema::Result::Map::FeaturemapPub;

use strict;
use parent qw/Bio::Chado::Schema::Result::Map::FeaturemapPub/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

