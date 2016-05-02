#!/usr/bin/perl -w

use strict;
use Getopt::Std;

my %optHash;

getopt('abc',\%optHash);

foreach my $key (sort keys %optHash) {
    print "$key: $optHash{$key}\n";
}

# variables are expected in the format: -a 2 -b 3 -c 5
