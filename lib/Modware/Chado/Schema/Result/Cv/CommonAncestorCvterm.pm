
package Modware::Chado::Schema::Result::Cv::CommonAncestorCvterm;

use strict;
use parent qw/Bio::Chado::Schema::Result::Cv::CommonAncestorCvterm/;

__PACKAGE__->load_components(qw/+Modware::DBIx::Class::Helper::Row::SubClass Core/);
__PACKAGE__->subclass;

1;

