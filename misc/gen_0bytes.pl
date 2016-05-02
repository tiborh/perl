#!/usr/bin/perl -w

use strict;

if (!@ARGV) {
    die "Give the number of bytes.\n";
}

for(my $i=0; $i<$ARGV[0]-1; $i++) {
    print(0);
}
print("\n");
