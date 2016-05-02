#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    title  => "Filling background color in the chart",
    bg     => {
        color   => "#c9c9ff",
        density => 0.2,
    },
    plotbg     => {
        color   => "blue",
        density => 0.2,
    },
);

my $dataSet = Chart::Gnuplot::DataSet->new(
    func => "sin(x)",
);

$chart->plot2d($dataSet);
