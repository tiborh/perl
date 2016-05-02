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

use Chart::Split;

my $g = Chart::Split->new(650, 900);
# Get the data from a file and push them into arrays
my $fh;
open($fh, "data.dat") or die "Can't open the data file!\n";
my (@x, @y) = ();
while (<$fh>) {
    chomp;
    my ($x, $y) = split "\t",$_;
    #say "x == $x, y == $y";
    push (@x, $x);
    push (@y, $y);
}
#say "\@y == @y";
close($fh);
# Add the data
$g->add_dataset(@x);
$g->add_dataset(@y);
# Set the options
$g->set('xy_plot'        => 'true');
$g->set('legend'         => 'none');
$g->set('title'          => 'Split Demo');
#$g->set('interval'       => 1/288);
$g->set('interval'       => int(scalar(@x)/10)); # Sets the interval of one segment to plot.
$g->set('interval_ticks' => 11);  # Sets the number of ticks for the x axis.
$g->set('start'          => 0);	  # Sets the start value of the rst interval.
$g->set('brush_size'     => 1);
$g->set('precision'      => 4);
$g->set('y_label'        => '5 minutes interval');

use File::Basename;

my $bn = (split /\./,basename($0))[0];
$g->png("$bn.png");
