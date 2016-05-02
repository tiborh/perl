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
        linetype => "longdash",
	color => 'red',
        xlines   => "on"
    },
    minorgrid   => {
        linetype => "dot-longdash",
	color => 'blue',
        xlines   => "on"
    },
    bg => 'white',
);

my $dataSet = Chart::Gnuplot::DataSet->new(
    func => "sin(x)",
);

$chart->plot2d($dataSet);
