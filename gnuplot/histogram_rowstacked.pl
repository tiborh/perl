#!/usr/bin/perl -w
# source: http://chartgnuplot.sourceforge.net/plotStyle.html
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

# Initiate the chart object
my $chart = Chart::Gnuplot->new(
    output            => "gallery/$bn.png",
    title             => "Rowstacked histogram",
    yrange            => [0, '*'],
    legend            => {position => 'left'},
    "style histogram" => "rowstacked",
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    },
);

# Raw data
my @x = qw(A B C D E F);
my @y1 = (1, 8, 3, 2, 4, 4);
my @y2 = (2, 2, 5, 1, 7, 6);
my @y3 = (4, 3, 2, 2, 3, 5);

# DataSet object of the 1st data set
my $h1 = Chart::Gnuplot::DataSet->new(
    xdata => \@x,
    ydata => \@y1,
    title => "1st data set",
    fill  => {density => 0.2},
    style => "histograms",
);

# DataSet object of the 2nd data set
my $h2 = Chart::Gnuplot::DataSet->new(
    xdata => \@x,
    ydata => \@y2,
    title => "2nd data set",
    color => "dark-green",
    fill  => {density => 0.2},
    style => "histograms",
);

# DataSet object of the 3rd data set
my $h3 = Chart::Gnuplot::DataSet->new(
    xdata => \@x,
    ydata => \@y3,
    title => "3rd data set",
    fill  => {density => 0.2},
    style => "histograms",
);

# Plot the graph
$chart->plot2d($h1, $h2, $h3);
