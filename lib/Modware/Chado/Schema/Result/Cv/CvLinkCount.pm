
package Modware::Chado::Schema::Result::Cv::CvLinkCount;

use strict;
use parent qw/Bio::Chado::Schema::Result::Cv::CvLinkCount/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

