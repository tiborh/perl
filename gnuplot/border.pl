#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    title  => {
	text => "Line type of the graph border",
	color => '#ff00ff',
    },
    legend => {
	position => "right center outside",
    },
    border => {
        linetype => 3,
	width => 2,
	color => '#ff00ff',
    },
    plotbg => 'black',
    bg => "light-grey",
);

my $dataSet = Chart::Gnuplot::DataSet->new(
    title => "sin(x)",
    func => "sin(x)",
);

$chart->plot2d($dataSet);
