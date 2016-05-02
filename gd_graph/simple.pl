#!/usr/bin/perl
use GD::Graph::bars;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my @A = (-3..3); # X
my @B = map {$_ * $_} @A;	      # y

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
