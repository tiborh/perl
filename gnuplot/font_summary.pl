#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

#-----------------------------------------------
# Demonstrate setting sophisticated chart title
#-----------------------------------------------

# Initiate the chart object
my $chart = Chart::Gnuplot->new(
    output  => "gallery/$bn.png",
    title   => {
        text     => "My so^{phis}ticate_d title",
        font     => "arial, 20",
        color    => "blue",
        offset   => "-10, 2",
        enhanced => 'on',
    },
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    },
);

# Data sets
my $cos = Chart::Gnuplot::DataSet->new(
    func => "cos(x)",
);

# Plot the graph
$chart->plot2d($cos);
