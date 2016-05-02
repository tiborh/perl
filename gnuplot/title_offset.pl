#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn_root = (split /\./,basename($0))[0];
#print($bn_root,"\n"); # name w/o extension

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn_root.png",
    title  => {
	text => 'My chart title',     # chart title
	offset => "3, 2",
    },
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
