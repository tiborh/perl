#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;

# Chart object
my $chart = Chart::Gnuplot->new(
    output => "gallery/dataSrc_3.png",
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    }
);

# Data set object
my $dataSet = Chart::Gnuplot::DataSet->new(
    datafile => "space_sep.dat",
    style     => "points",
    pointtype => "fill-circle",
);

$chart->plot2d($dataSet);
