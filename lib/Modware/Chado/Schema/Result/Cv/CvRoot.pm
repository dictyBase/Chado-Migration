
package Modware::Chado::Schema::Result::Cv::CvRoot;

use strict;
use parent qw/Bio::Chado::Schema::Result::Cv::CvRoot/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

