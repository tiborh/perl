#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.eps",
    xlabel => "data things",
    yrange => [0, 6],
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    },
);

my $ds = Chart::Gnuplot::DataSet->new(
    xdata => [1,2,3,4,5],
    ydata => [1, 2, 5,2,1],
    #using => "2:xticlabels(1)",
    style => "histograms",
    );

$chart->plot2d($ds);
