#!/usr/bin/perl -w

use strict;
use XML::Simple;
use Data::Dumper;
binmode STDOUT, 'encoding(UTF-8)';

my $debug = 1;

my $year_xml = XMLin('./array_ref.xml');

print Dumper($year_xml) if ($debug == 1);

&print_structure($year_xml) if ($debug == 0);

sub print_structure {
    my $year_xml = $_[0];

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

}
