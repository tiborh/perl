#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

# Demonstration of formatting legend
# - position of the legend

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    legend => {
        position => 'right center outside',
	height => 2,
	title => 'legend',
	border => {
            linetype => 2,
            width    => 2,
            color    => "navy",
	},
    },
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    }
);

# Lines
my $lines = Chart::Gnuplot::DataSet->new(
    func  => "cos(x)",
    title => "cosine",
);

# Points
my $points = Chart::Gnuplot::DataSet->new(
    func  => "sin(x)",
    title => "sine",
);

# Points on line
my $linespoints = Chart::Gnuplot::DataSet->new(
    func  => "x**2",
    title => "quadratic",
);

# Plot the graph
$chart->plot2d($lines, $points, $linespoints);
