#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    xtics  => {
        minor => 3,
    },
    grid   => {
        width  => "0.5, 0.25",
	color  => 'blue, #228b22',
        xlines => "on, on",
    },
    bg => 'light-grey',
);

my $dataSet = Chart::Gnuplot::DataSet->new(
    func => "sin(x)",
);

$chart->plot2d($dataSet);
