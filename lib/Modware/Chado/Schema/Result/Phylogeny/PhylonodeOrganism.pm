
package Modware::Chado::Schema::Result::Phylogeny::PhylonodeOrganism;

use strict;
use parent qw/Bio::Chado::Schema::Result::Phylogeny::PhylonodeOrganism/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

