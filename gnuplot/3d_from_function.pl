#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    title  => "3D plot from function",
    bg => "white",
);


my $dataSet = Chart::Gnuplot::DataSet->new(
    func => "exp(-(x**2 + y**2)/5)",
);

$chart->plot3d($dataSet);
