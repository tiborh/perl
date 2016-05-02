#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;

# Chart object
my $chart = Chart::Gnuplot->new(
    output => "gallery/dataSrc_4.png",
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    }
);

# Data set object
my $dataSet = Chart::Gnuplot::DataSet->new(
    func => "sin(x)",
    style     => "points",
    pointtype => "fill-circle",
);

$chart->plot2d($dataSet);
