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

use Chart::Composite;

my $g = Chart::Composite->new(800,600);

$g->add_dataset(1, 2, 3, 4, 5, 6);
$g->add_dataset(0.1, 0.2, 0.3, 0.2, 0.4, 0.1);
$g->add_dataset(0.3, 0.5, 0.2, 0.6, 0.7, 0.4);
$g->add_dataset(10,  11,  6,   7,   7,   8);
$g->set ('legend_labels' => [qw(one two three)]);
$g->set('composite_info' => [ ['Bars',        [1, 2]],
			      ['LinesPoints', [3]  ]
	],
	'title'                     => 'Composite Chart',
	'legend'                    => 'bottom',
	'legend_example_height'     => 'true',
	'legend_example_height0..1' => 10,
	'legend_example_height2'    =>  3,
    );
$g->set('include_zero'  => 'true');

use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png");
