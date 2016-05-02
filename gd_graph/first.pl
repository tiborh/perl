#!/usr/bin/perl
use GD::Graph::bars;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my @A = (-3..3); # X
my @B = qw(-6 -4 -2 0 2 4 6);	      # y

my @data = ([@A],[@B]);
my $graph = GD::Graph::bars->new(600,400);

$graph->set(
    transparent => '0',
    x_label     => 'A',
    y_label     => 'B',
    title       => 'A for B',
);
open(IMG, ">$bn.png");
binmode IMG;
my $gd =  $graph->plot(\@data);
print IMG $gd->png;
close IMG;
