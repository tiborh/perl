#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

# Demonstration of formatting legend
# - title of the legend

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    title  => 'Legend with title',
    legend => {
	position => 'right center outside',
        title  => 'Legend title', # overrules all border options in current version
	border => 'on',		  # ineffective
	height => "3",
	#border => { #does not work with title
	#    linetype => 2,
	#    width    => 2,
	#}
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
