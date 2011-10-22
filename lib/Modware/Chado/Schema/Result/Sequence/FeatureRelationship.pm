
package Modware::Chado::Schema::Result::Sequence::FeatureRelationship;

use strict;
use parent qw/Bio::Chado::Schema::Result::Sequence::FeatureRelationship/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

