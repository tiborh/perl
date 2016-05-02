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

use Chart::Direction;

my $g = Chart::Direction->new(500,500);
$g->add_dataset( 0, 100, 50, 200, 280, 310);
$g->add_dataset(30,  40, 20,  35,  45,  20);
$g->add_dataset(10, 110, 60, 210, 290, 320);
$g->add_dataset(20,  30, 40,  20,  35,  45);
$g->add_dataset(20, 120, 70, 220, 300, 330);
$g->add_dataset(45,  20, 30,  40,  20,  35,);
my %hash = ( 'title'           => 'Direction Demo',
	     'angle_interval'  => 45,
	     'precision'       => 0,
	     'arrow'           => 'true',
	     'point'           => 'false',
	     'include_zero'    => 'true',
	     'pairs'           => 'true',
	     'legend'          => 'none',
	     # cannot handle pairs gracefully with legends
	     #'legend'          => 'right',
	     #'legend_labels'   => [qw(one two three four five)],
	     'grey_background' => 'false'
    );
$g->set(%hash);

use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png");