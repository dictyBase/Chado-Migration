
package Modware::Chado::Schema::Result::Cv::Dbxrefprop;

use strict;
use parent qw/Bio::Chado::Schema::Result::Cv::Dbxrefprop/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

