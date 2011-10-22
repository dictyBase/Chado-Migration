
package Modware::Chado::Schema::Result::Phenotype::PhenotypeCvterm;

use strict;
use parent qw/Bio::Chado::Schema::Result::Phenotype::PhenotypeCvterm/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

