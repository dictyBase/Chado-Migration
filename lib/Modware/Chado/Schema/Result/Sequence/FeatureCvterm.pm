
package Modware::Chado::Schema::Result::Sequence::FeatureCvterm;

use strict;
use parent qw/Bio::Chado::Schema::Result::Sequence::FeatureCvterm/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

