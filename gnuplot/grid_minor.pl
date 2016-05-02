#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

# - Minor grid lines will be added if the minor axis tics are added
# - Minor grid lines cannot be drawn if the minor axis tics are not added

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    title  => "Add minor grid lines",
    xlabel => "major and minor grid lines",
    ylabel => "only minor grid lines",

    xtics => {
        minor => 4,
    },
    ytics => {
        minor => 2,
    },

    grid => {
        xlines => 'on',     # draw major grid lines
        ylines => 'off',    # no major grid lines
    },

    minorgrid => 'on',    # draw minor grid lines
    bg => 'white',
);

my $dataSet = Chart::Gnuplot::DataSet->new(
    func => "sin(x)",
);

$chart->plot2d($dataSet);
