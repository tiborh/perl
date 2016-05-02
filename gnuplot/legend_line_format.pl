#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

# Demonstration of formatting legend
# - format the sample lines

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    title  => "Format the sample lines",
    legend => {
        sample => {
            length   => 10,
            position => 'left',	# the lines are left, not the text
            spacing  => 2,
        }
    },
    bg => 'white',
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
