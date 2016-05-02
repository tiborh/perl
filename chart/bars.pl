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

use Chart::Bars;

my $g = Chart::Bars->new(600,500);
$g->add_dataset('Berlin', 'Paris', 'Rome', 'London', 'Munich');
$g->add_dataset(14, 5, 4, 5, 11);
$g->add_dataset(12, 4, 6, 7, 12);
$g->add_dataset(18, 2, 3, 3, 9);
$g->add_dataset(17, 5, 7, 6, 6);
$g->add_dataset(15, 3, 4, 5, 11);
$g->add_dataset(11, 6, 5, 6, 12);
$g->add_dataset(12, 1, 4, 5, 15);
$g->add_dataset(10, 4, 6, 8, 10);
$g->add_dataset(14, 5, 4, 5, 11);
$g->add_dataset(12, 4, 6, 6, 12);
$g->add_dataset(18, 2, 3, 3, 9);
$g->add_dataset(17, 5, 7, 2, 6);
my %hash = ('title' => 'Sold Cars in 2001',
	    'text_space'         => 5,
	    'grey_background'    => 'false',
	    'integer_ticks_only' => 'true',
	    'x_label'            => 'City',
	    'y_label'            => 'Number of Cars',
	    'legend'             => 'bottom',
	    'legend_labels'      => ['January',  'February',
				     'March',    'April',
				     'May',      'June',
				     'July',     'August',
				     'September','October',
				     'November', 'December'
	    ],
	    'min_val'            => 0,
	    'max_val'            => 20,
	    'grid_lines'         =>'true',
	    'colors'             => {'title'   => 'red',
				     'x_label' => 'blue',
				     'y_label' => 'blue'
	    }
    );
$g->set(%hash);

use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png");

