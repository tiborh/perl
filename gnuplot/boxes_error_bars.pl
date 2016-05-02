#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;

#-----------------------------------------------------------
# Demonstrate of styles of combination of box and error bars
#-----------------------------------------------------------

# Initiate the chart object
my $chart = Chart::Gnuplot->new(
    output => 'gallery/plotStyle_10.png',
    title  => 'Box error bar styles',
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    },
    legend => {
        position => "top left",
    	#border => "on",	# if "on", looks pretty stupid
    	sample => {
            length   => 10,
            position => 'left',
            spacing  => 2,
        }
    },
);

# Style of combination of boxes and y error bars
my @x = (1, 2, 3, 4, 5, 6);
my @y = (0, 1, 2, 3, 4, 5);
my @xerr = (0.5, 0.4, 0.1, 0, 0.3, 0.6);
my $boxerrorbars = Chart::Gnuplot::DataSet->new(
    xdata => [@x],
    ydata => [[@y], [@xerr]],
    style => 'boxerrorbars',
    title => 'box error bars',
);

# Style of combination of boxes and x-y error bars
@y = (2, 3, 4, 5, 6, 7);
my @yerr = (0.5, 0.4, 0.2, 0.2, 0.4, 0.7);
my $boxxyerrorbars = Chart::Gnuplot::DataSet->new(
    xdata => [[@x], [@xerr]],
    ydata => [[@y], [@yerr]],
    style => 'boxxyerrorbars',
    title => 'box xy error bars',
);

# Plot the graph
$chart->plot2d($boxerrorbars, $boxxyerrorbars);
