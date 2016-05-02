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

use Chart::Points;

my $g = Chart::Points->new();
$g->add_dataset(1, 4,   3, 6, 2, 2.5);  # x-coordinates
$g->add_dataset(1, 5,   3, 2, 3, 3.2);  # y-coordinates dataset 1
$g->add_dataset(2, 6, 4.8, 1, 4, 4.2);  # y-coordinates dataset 2
my @hash = ('title'        => 'Points Chart',
	 'xy_plot'      => 'true',
	 'x_ticks'      => 'vertical',
	 'legend'       => 'none',
	 'sort'         => 'true',
	 'precision'    => 3,
	 'include_zero' => 'true',
    );
$g->set(@hash);

use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png");
