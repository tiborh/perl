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

use Chart::Mountain;
my $g = Chart::Mountain->new(800,600);

my $data = [ [1910, 1930, 1950, 1970],
	  [1, 3, 4, 2],
	  [2, 4, 3, 3],
	     [0.5, 1, 2, 1]];
$g->set('title'      => 'Mountain Chart',
	'grid_lines' => 'false',
	'precision'  => 1);
$g->set ('legend_labels' => [qw(one two three)]);
use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png",$data);

