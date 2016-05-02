#!/usr/bin/perl -w

use strict;
my %collect_hash = ();
while (<>) {
    chomp;
    my @caught_str = ($_ =~ /<[^>\/?!]+>/g);
    foreach (@caught_str) {
#	print $_,"\n";
	$collect_hash{$_}++;
    }
}
foreach (sort keys %collect_hash) {
    print "$_ => $collect_hash{$_}\n";
}
print scalar(keys %collect_hash),"\n";
