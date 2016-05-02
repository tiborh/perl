#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;

my $chart = Chart::Gnuplot->new(
    output => 'gallery/chartFmt_4.png',
    title  => "Add grid lines",
    grid   => "on",
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    }
);

my $data = Chart::Gnuplot::DataSet->new(
    func => "tanh(x)",
);

# Plot the graph
$chart->plot2d($data);
