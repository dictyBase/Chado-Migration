
package Modware::Chado::Schema::Result::Pub::PubRelationship;

use strict;
use parent qw/Bio::Chado::Schema::Result::Pub::PubRelationship/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

