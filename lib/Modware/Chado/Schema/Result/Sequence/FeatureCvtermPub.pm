
package Modware::Chado::Schema::Result::Sequence::FeatureCvtermPub;

use strict;
use parent qw/Bio::Chado::Schema::Result::Sequence::FeatureCvtermPub/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

