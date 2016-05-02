#!/usr/bin/perl -w

use strict;

my $for_count = 0;

foreach (@ARGV) {
    # print("$ARGV[$for_count] ");
    if (open(INFILE, "<$ARGV[$for_count]")) {
	while(<INFILE>) {
	    print $_;
	}
	close(INFILE);
    }
    else {
	warn "Cannot open file \"$ARGV[$for_count]\" for read: $!";
    }
    ++$for_count;
}

print("\n");

#end of cat.pl
