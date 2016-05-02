#!/usr/bin/perl -w

use strict;

my %theYear = (
    "Spring (春)" => ["March （三月）","April （四月）","May （五月）"],
    "Summer （夏）" => ["June （六月）","July （七月）","August （八月）"],
    "Autumn （秋）" => ["September （九月）","October （十月）","November （十一月）"],
    "Winter （冬）" => ["December （十二月）","January （一月）","February （二月）"],
);

print "<theYear>\n";
foreach my $season (keys %theYear) {
    print "\t<season name=\"$season\">\n";
    for my $month (@{$theYear{$season}}) {
	print "\t\t<month>$month</month>\n";
    }
    print "\t</season>\n";
}
print "</theYear>\n";
