
package Modware::Chado::Schema::Result::Sequence::FeatureRelationshippropPub;

use strict;
use parent qw/Bio::Chado::Schema::Result::Sequence::FeatureRelationshippropPub/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

