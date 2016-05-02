#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;
use Math::Trig;

my $bn = (split /\./,basename($0))[0];

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    xlabel => "Re-label the tics",
    xtics  => {
        labels => ['"pi" 3.1416', '"-pi" -3.1416'],
    },
    xrange => ["-pi", "pi"],
    bg     => {
        color   => "#a2a2ff",
        density => 0.3,
    },
    legend => {
	position => "top left",
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
