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

use Chart::Pareto;

my $g = Chart::Pareto->new(500,400);
$g->add_dataset('1st week', '2nd week', '3rd week', '4th week',
		'5th week', '6th week', '7th week', '8th week',
		'9th week', '10th week');
$g->add_dataset(37, 15, 9, 4, 3.5, 2.1, 1.2, 1.5, 6.2, 16);
my %hash = ('colors' => { 'dataset0' => 'mauve',
			  'dataset1' => 'light_blue',
			  'title' => 'orange'
	    },
	    'title'              => 'Visitors at the Picasso Exhibition',
	    'integer_ticks_only' => 'true',
	    'skip_int_ticks'     => 5,
	    'grey_background'    => 'false',
	    'max_val'            => 100,
	    'y_label'            => 'Visitors in Thousands',
	    'x_ticks'            => 'staggered',
	    'spaced_bars'        => 'true',
	    'legend'             => 'none'
    );
$g->set(%hash);


use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png");

