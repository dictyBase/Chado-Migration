
package Modware::Chado::Schema::Result::Cv::Cv;

use strict;
use parent qw/Bio::Chado::Schema::Result::Cv::Cv/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

