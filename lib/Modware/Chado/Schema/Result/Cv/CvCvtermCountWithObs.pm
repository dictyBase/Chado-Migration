
package Modware::Chado::Schema::Result::Cv::CvCvtermCountWithObs;

use strict;
use parent qw/Bio::Chado::Schema::Result::Cv::CvCvtermCountWithObs/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

