#!/usr/bin/perl -w

use strict;

my %words;

print("Give me some strings (<enter> separated):\n");

while (<>) {
    chomp;
    if (exists $words{$_}) {
	$words{$_}++;
    } else {
	$words{$_}=1;
    }
}

foreach (sort(keys(%words))) {
    print("$_:\t",length($_)<7?"\t":"",$words{$_},"\n");
}

