#!/usr/bin/perl
use GD::Graph::bars;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

@A = (-3..3);
@B = qw(-6 -4 -2 0 2 4 6);
@C = qw(1 2 3 4 5);
@D = qw(4 5 6 7);
@E = qw(-2 -4 -6 0 2 4 6 8);

# predefined colours:
# white, lgray, gray, dgray, black, lblue, blue, dblue, gold, lyellow, yellow, dyellow, lgreen, green, dgreen, lred, red, dred, lpurple, purple, dpurple, lorange, orange, pink, dpink, marine, cyan, lbrown, dbrown

@datacolors = qw(green cyan pink yellow);

my @data = ([@A],[@B],[@C],[@D],[@E]);
my $graph = GD::Graph::bars->new(800,600);

$graph->set(
    transparent => '0',
    x_label     => 'A',
    y_label     => 'B',
    title       => 'A for B',
    dclrs => [ @datacolors ],
    legend_placement    => 'RC',
    # overwrite => 1,		# quite meaningless here
    show_values => 1,
    values_format       => "%3.1f",
    r_margin            => 20,
    );
$graph->set_legend("A","B","C","D","E");
open(IMG, ">$bn.png");
binmode IMG;
my $gd =  $graph->plot(\@data);
print IMG $gd->png;
close IMG;
