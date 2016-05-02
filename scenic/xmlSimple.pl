#!/usr/bin/perl -w

use strict;
use XML::Simple;
binmode STDOUT, 'encoding(UTF-8)';

my $year_xml = XMLin('./array_ref.xml');

for my $year (keys %{$year_xml}) {
    my %xmlYear = %{$year_xml};
    for my $season (keys %{$xmlYear{$year}}) {
	my %xmlSeason = %{$xmlYear{$year}};
     	print "$season\n";
	for my $months (keys %{$xmlSeason{$season}}) {
	    my %xmlMonths = %{$xmlSeason{$season}};
	    for my $month (@{$xmlMonths{$months}}) {
		print "\t$month\n";
	    }
	}
    }
}
