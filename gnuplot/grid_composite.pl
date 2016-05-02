#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

# Create the chart object
my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    xtics  => {
        minor => 4
    },
    ytics  => {
        minor => 4
    },
    grid   => {
        linetype => 'longdash, dot-longdash',
        color    => 'light-blue',
        width    => '3, 1',
        xlines   => 'off, on',
    },
    bg => 'white',
);

# Data set object
my $data = Chart::Gnuplot::DataSet->new(
    func => 'sin(x)',
);

# Plot the graph
$chart->plot2d($data);
