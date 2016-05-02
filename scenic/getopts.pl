#!/usr/bin/perl -w

use strict;
use Getopt::Std;

my %optHash;

getopts('ab:c',\%optHash);

foreach my $key (sort keys %optHash) {
    print "$key: $optHash{$key}\n";
}

# variables are expected in the format: -a -b 3 -c (-a and -c do not take a value.)
