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

use Chart::StackedBars;

my $g = Chart::StackedBars->new(800,600);
$g->add_dataset(qw(foo bar junk taco karp));
$g->add_dataset(3, 4, 9, 10, 11);
$g->add_dataset(8, 6, 1, 12, 1);
$g->add_dataset(5, 7, 2, 13, 4);
$g->set('title'        => 'Stacked Bar Chart');
$g->set('y_grid_lines' => 'true');
$g->set ('legend_labels' => [qw(one two three)]);
$g->set('legend'       => 'bottom');

use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png");

