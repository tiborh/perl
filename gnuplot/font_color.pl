#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    title  => {
        text     => "Font Color and Size",
        font => "Courier, 20",
	color => "dark-red",
    },
    legend => {
	position => "bottom right"
    },
    bg     => {
        color   => "white",
    }
);

my $dataSet = Chart::Gnuplot::DataSet->new(
    func => "sin(x)",
    title => "sine",
);

$chart->plot2d($dataSet);
