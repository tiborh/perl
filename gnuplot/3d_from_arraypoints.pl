#!/usr/bin/perl -w
use strict;
use Chart::Gnuplot;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

# Input data source
my @points = ();
for (my $x = -5; $x < 5; $x += 0.02)
{
	my $y = sin($x*3);
	my $z = cos($x*3);

	push(@points, [$x, $y, $z]);
}

my $chart = Chart::Gnuplot->new(
    output => "gallery/$bn.png",
    title  => "3D plot from Perl array of points",
    bg => "white",
);


my $dataSet = Chart::Gnuplot::DataSet->new(
    points => \@points,
);

$chart->plot3d($dataSet);
