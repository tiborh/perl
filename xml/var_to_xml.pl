#!/usr/bin/perl -w

use strict;
use XML::Simple;
use Data::Dumper;

my $debug = 0;

my $theYear = {
    "Spring (春)" => ["March (三月)","April (四月)","May (五月)"],
    "Summer (夏)" => ["June (六月)","July (七月)","August (八月)"],
    "Autumn (秋)" => ["September (九月)","October (十月)","November (十一月)"],
    "Winter (冬)" => ["December (十二月)","January (一月)","February (二月)"],
};

&debug_print($theYear) if ($debug == 2);

print Dumper($theYear) if ($debug == 1);

&check_xmlout($theYear) if ($debug == 0);

sub check_xmlout() {
    my $fh;
    my $fm = ">";
    my $fn = "./var_to_xml.xml";
    open ($fh,$fm,$fn) or die "Unable to open file $fn.\n $!";
    my $xml = XMLout($_[0], OutputFile => $fh);
    close $fh;
    print "Structure has been written to $fn.\n";
    return;
}

sub debug_print {
    for my $level1 (keys %{$_[0]}) {
	print "$level1\n";
	foreach (@{${$_[0]}{$level1}}) {
	    print "\t$_\n"; 
	}
    }
    return;
}
