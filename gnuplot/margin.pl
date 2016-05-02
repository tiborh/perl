#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my $chart = Chart::Gnuplot->new(
    output  => "gallery/$bn.png",
    title   => "Margin",
    bmargin => 10,  # bottom margin: 10 characters height
    rmargin => 20,  # right margin: 20 characters width
    bg => "white",
);

my $dataSet = Chart::Gnuplot::DataSet->new(
    func => "sin(x)",
);

$chart->plot2d($dataSet);
