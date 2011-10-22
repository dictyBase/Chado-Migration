
package Modware::Chado::Schema::Result::Organism::Organism;

use strict;
use parent qw/Bio::Chado::Schema::Result::Organism::Organism/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;
__PACKAGE__->remove_column('comment');
__PACKAGE__->add_column(
'comment_', 
  { data_type => "clob", default_value => \"NULL", is_nullable => 1 },
);
1;

