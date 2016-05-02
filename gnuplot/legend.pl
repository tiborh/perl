#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    }
);

my $data = Chart::Gnuplot::DataSet->new(
    func  => "tanh(x)",
    title => 'legend',     # legend
);

# Plot the graph
$chart->plot2d($data);
