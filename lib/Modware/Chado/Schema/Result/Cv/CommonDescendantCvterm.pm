
package Modware::Chado::Schema::Result::Cv::CommonDescendantCvterm;

use strict;
use parent qw/Bio::Chado::Schema::Result::Cv::CommonDescendantCvterm/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

