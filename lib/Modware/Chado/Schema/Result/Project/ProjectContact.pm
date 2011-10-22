
package Modware::Chado::Schema::Result::Project::ProjectContact;

use strict;
use parent qw/Bio::Chado::Schema::Result::Project::ProjectContact/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

