
package Modware::Chado::Schema::Result::Cv::Cvtermpath;

use strict;
use parent qw/Bio::Chado::Schema::Result::Cv::Cvtermpath/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

