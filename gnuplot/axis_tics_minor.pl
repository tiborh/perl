#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    xlabel => "Three minor tics between every two major tics",
    xtics  => {
        minor => 3
    },
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    }
);

my $dataSet = Chart::Gnuplot::DataSet->new(
    func => "sin(x)",
);

$chart->plot2d($dataSet);
