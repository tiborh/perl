#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;

my $chart = Chart::Gnuplot->new(
    output => "gallery/plotStyle_3.png",
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    }
);

# Impulses
my $impulses_cos = Chart::Gnuplot::DataSet->new(
    func  => "cos(x)",
    style => "impulses",
);
my $impulses_sin = Chart::Gnuplot::DataSet->new(
    func  => "sin(x)",
    style => "impulses",
);

# Plot the graph
$chart->plot2d($impulses_cos,$impulses_sin);
