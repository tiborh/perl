#!/usr/bin/perl -w

use strict;
use utf8;

my %tagCount = ();
my @collect_matches = ();

while (<>) {
    chomp;
    if (@collect_matches = /(<\w+(?:-\w+)?)(?:\s+[^>]+)?>/g) {
	foreach my $tag (@collect_matches) {
	    $tagCount{$tag.">"} += 1;
	}
#	print "$_\n";
    }
}

#while ( ($hkey, $hvalue) = each %tagCount ) {
#    print "$hkey => $hvalue\n";
#}

foreach my $hkey (sort keys %tagCount) {
    print "$hkey => $tagCount{$hkey}\n";
}

print "\n";

foreach my $hkey (sort {$tagCount{$b} <=> $tagCount{$a}} keys %tagCount) {
    print "$hkey => $tagCount{$hkey}\n";
}
