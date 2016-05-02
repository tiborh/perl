#!/usr/bin/perl
use GD::Graph::hbars;
use File::Basename;

my $bn = (split /\./,basename($0))[0];

@A = (-3..3);
@B = map {$_ * $_} @A;
@C = map {abs($_) * 2} @A;
@D = map {$_ / 2} @B;
@E = map {abs($_)} @A;

# predefined colours:
# white, lgray, gray, dgray, black, lblue, blue, dblue, gold, lyellow, yellow, dyellow, lgreen, green, dgreen, lred, red, dred, lpurple, purple, dpurple, lorange, orange, pink, dpink, marine, cyan, lbrown, dbrown

@datacolors = qw(green cyan pink yellow);

my @data = ([@A],[@B],[@C],[@D],[@E]);
my $graph = GD::Graph::hbars->new(800,600);

$graph->set(
    transparent => '0',
    x_label     => 'A',
    y_label     => 'B',
    title       => 'A for B',
    dclrs => [ @datacolors ],
    legend_placement    => 'RC',
    # overwrite => 1,		# quite meaningless here
    #show_values => 1,
    #values_format       => "%3.1f",
    r_margin            => 20,
    cumulate        => 2,
    bar_spacing     => 8,
    shadow_depth	=> 2,
    );
$graph->set_legend("A","B","C","D","E");
open(IMG, ">$bn.png");
binmode IMG;
my $gd =  $graph->plot(\@data);
print IMG $gd->png;
close IMG;
