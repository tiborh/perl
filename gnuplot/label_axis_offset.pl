#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my $chart = Chart::Gnuplot->new(
    output  => "gallery/$bn.png",
    title   => "Default format of the axis labels",
    xlabel  => {
	text   => "Shifted rightwards and downwards",
	offset => "10, -2",
    },
    ylabel  => "y-label",
    x2label => "x2-label",
    y2label => "y2-label",
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    }
);

my $dataSet = Chart::Gnuplot::DataSet->new(
    func => "sin(x)",
);

$chart->plot2d($dataSet);
