
package Modware::Chado::Schema::Result::Composite::Gff3view;

use strict;
use parent qw/Bio::Chado::Schema::Result::Composite::Gff3view/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

