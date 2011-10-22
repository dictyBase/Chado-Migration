
package Modware::Chado::Schema::Result::Phylogeny::PhylotreePub;

use strict;
use parent qw/Bio::Chado::Schema::Result::Phylogeny::PhylotreePub/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

