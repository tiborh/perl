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

use Chart::HorizontalBars;
my $g = Chart::HorizontalBars->new();
$g->add_dataset('Foo', 'bar', 'junk', 'ding', 'bat');
$g->add_dataset(4, 3, 4, 2, 8);
$g->add_dataset(2, 10, 3, 8, 3);
my %hash = ( 'title'        => 'Horizontal Bars Demo',
	     'grid_lines'   => 'true',
	     'x_label'      => 'x axis',
	     'y_label'      => 'y axis',
	     'include_zero' => 'true',
	     'x_ticks'      => 'vertical',
	     'legend_labels'=> [qw(one two)],
    );
$g->set(%hash);

use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png");
