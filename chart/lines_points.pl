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

use Chart::LinesPoints;
my (@data1, @data2, @data4, @data3, @labels, %hash, $g);

@labels = qw(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17);
@data1  = qw (-7 -5 -6 -8 -9 -7 -5 -4 -3 -2 -4 -6 -3 -5 -3 -4 -6);
@data2  = qw (-1 -1 -1 -1 -2 -2 -3 -3 -4 -4 -6 -3 -2 -2 -2 -1 -1);
@data3  = qw (-4 -4 -3 -2 -1 -1 -1 -2 -1 -1 -3 -2 -4 -3 -4 -2 -2);
@data4  = qw (-6 -3 -2 -3 -3 -3 -2 -1 -2 -3 -1 -1 -1 -1 -1 -3 -3);

$g = Chart::LinesPoints->new(600,300);
$g->add_dataset(@labels);
$g->add_dataset(@data1);
$g->add_dataset(@data2);
$g->add_dataset(@data3);
$g->add_dataset(@data4);

%hash = ('integer_ticks_only' => 'true',
	 'title'         => 'Soccer Season 2002\n ',
	 'legend_labels' => ['NY Soccer Club', 'Denver Tigers',
			     'Houston Spacecats',
			     'Washington Presidents'],
	 'y_label'       => 'position in the table',
	 'x_label'       => 'day of play',
	 'grid_lines'    => 'true',
	 'f_y_tick'      => \&formatter,
    );
$g->set( %hash);

use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png");

# Just a trick to have the y scale start at the biggest point:
# Initialise with negative values, remove the minus sign!
sub formatter {
    my $label = shift;
    $label    = substr($label, 1);
    return $label;
}