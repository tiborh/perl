#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

use Chart::ErrorBars;

my $g = Chart::ErrorBars->new();
# the x values
$g->add_dataset(qw(1    1.1  1.2  1.3  1.4  1.5  1.6  1.7
1.8  1.9  2    2.1  2.2  2.3  2.4  2.5));
# the y values
$g->add_dataset(qw(1    1.1  1.2  1.1  1.14 1.15 1.26 1.2
1.1  1.19 1.2  1.4  1.6  2.0  2.5  3.1));
# the upper errors
$g->add_dataset(qw(0.4  0.1  0.2  0.1  0.14 0.15 0.26 0.27
0.1  0.19 0.2  0.1  0.1  0.2  0.1  0.3));
# the lower errors
$g->add_dataset(qw(0.2  0.11 0.12 0.11 0.2  0.3  0.12 0.27
0.11 0.3  0.2  0.2  0.2  0.1  0.1  0.2));
$g->set( 'xy_plot'    => 'true',
	 'precision'  => 1,
	 'pt_size'    => 10,
	 'brush_size' => 2,
	 'legend'     => 'none',
	 'title'      => 'Error Bars Demo',
	 'grid_lines' => 'true'
    );

use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png");
