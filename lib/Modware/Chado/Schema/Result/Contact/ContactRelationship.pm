
package Modware::Chado::Schema::Result::Contact::ContactRelationship;

use strict;
use parent qw/Bio::Chado::Schema::Result::Contact::ContactRelationship/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

