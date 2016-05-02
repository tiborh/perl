#!/usr/bin/perl -w

use strict;
use XML::Simple;
binmode STDOUT, 'encoding(UTF-8)';

my $year_xml = XMLin('./array_ref.xml');

for my $year (keys %{$year_xml}) {
    for my $season (keys %{${$year_xml}{$year}}) {
     	print "$season\n";
	for my $months (keys %{${${$year_xml}{$year}}{$season}}) {
	    for my $month (@{${${${$year_xml}{$year}}{$season}}{$months}}) {
		print "\t$month\n";
	    }
	}
    }
}
