#!/usr/bin/perl -w

use strict;

my $for_count = 0;
my @ar_tmp = ();

foreach (@ARGV) {
    # print("$ARGV[$for_count] ");
    if (open(INFILE, "<$ARGV[$for_count]")) {
	@ar_tmp = <INFILE>;
    }
    else {
	warn "Cannot open file \"$ARGV[$for_count]\" for read: $!";
    }
    print(reverse(@ar_tmp));
    ++$for_count;
}

#end of tac.pl
