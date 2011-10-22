
package Modware::Chado::Schema::Result::Cv::Cvtermsynonym;

use strict;
use parent qw/Bio::Chado::Schema::Result::Cv::Cvtermsynonym/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;
__PACKAGE__->remove_column('synonym');
__PACKAGE__->add_column(
'synonym_', 
  { data_type => "varchar2", is_nullable => 0, size => 1024 },
);

1;

