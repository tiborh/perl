#!/usr/bin/perl -w

use strict;

my @files = <*>;

foreach my $file (@files) {
    print "$file\n";
}
