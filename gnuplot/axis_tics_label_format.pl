#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;
use Math::Trig;

my $bn = (split /\./,basename($0))[0];

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    xlabel => {
	text => "Re-label the tics",
	offset => "0, -2",
    },
    xtics  => {
	font => "Times-Italic, 20",
	fontcolor => "red",
        labelfmt => '%+5.2f',
	rotate => '45',
	offset => "-4, -3",
        length => "5, 3",	# make them longer
        minor  => 4, 		# minor is a little shorter
	mirror => 'off',	# remove from opposite
    },
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    },
    legend => {
	position => "outside center right",
    },
);

my $sineSet = Chart::Gnuplot::DataSet->new(
    func => "sin(x)",
    title => "sine",
);

my $cosineSet = Chart::Gnuplot::DataSet->new(
    func => "cos(x)",
    title => "cosine",
);


$chart->plot2d($sineSet,$cosineSet);
