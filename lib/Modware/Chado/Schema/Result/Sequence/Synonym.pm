
package Modware::Chado::Schema::Result::Sequence::Synonym;

use strict;
use parent qw/Bio::Chado::Schema::Result::Sequence::Synonym/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;
__PACKAGE__->table('synonym_');

1;

