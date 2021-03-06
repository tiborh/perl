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

use Chart::Lines;
my $g = Chart::Lines->new();
$g->add_dataset('foo', 'bar', 'junk', 'ding', 'bat');
$g->add_dataset( -4,  3, -4, -5, -2);
$g->add_dataset(  2, 10, -3,  8,  3);
$g->add_dataset(-10,  2,  4, -3, -3);
$g->add_dataset(  7, -5, -3,  4,  7);
my %hash = ('legend_labels' => ['1st Quarter', '2nd Quarter',
			     '3rd Quarter', '4th Quarter'],
	 'y_axes'              => 'both',
	 'title'               => 'Lines Demo',
	 'grid_lines'          => 'true',
	 'legend'              => 'left',
	 'legend_example_size' => 20,
	 'legend_labels'       => [qw(one two three four)],
	 'colors' => {'text'       => 'blue',
		      'misc'       => 'blue',
		      'background' => 'grey',
		      'grid_lines' => 'light_blue',
		      'dataset0'   => [255,0,0],
		      'dataset1'   => [200,150,100],
		      'dataset2'   => [150,50,175],
		      'dataset3'   => [170,200,255]
	 }
    );
$g->set(%hash);

use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png");
