#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

my @years = (1975, 1980, 1985, 1990, 1995, 2000, 2005, 2010);
my @y1 = (0.5, 2.0, 2.5, 2.6, 2.0, 5.0, 10.2, 15.1);
my @y2 = (9.0, 12.0, 10.1, 9.1, 7.2, 8.0, 6.0, 6.2);
    
my $chart = Chart::Gnuplot->new(
    title => "Histogram Study",
    output => "gallery/$bn.eps",
    xlabel => "Years",
    ylabel => "Amount",
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    },
    legend => {
	position => "top left",
    },
);

my $hist1 = Chart::Gnuplot::DataSet->new(
    xdata => \@years,
    ydata => \@y1,
    #using => "2:xticlabels(1)",
    style => "histograms",
    title => "first set",
    );

my $hist2 = Chart::Gnuplot::DataSet->new(
    xdata => \@years,
    ydata => \@y2,
    #using => "2:xticlabels(1)",
    style => "histograms",
    title => "second set",
    );


$chart->plot2d($hist1,$hist2);
