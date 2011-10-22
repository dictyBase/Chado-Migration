
package Modware::Chado::Schema::Result::Project::Project;

use strict;
use parent qw/Bio::Chado::Schema::Result::Project::Project/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

