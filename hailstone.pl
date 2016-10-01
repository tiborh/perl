#!/usr/bin/env perl

die "You need a starting number." if @ARGV < 1;

use Scalar::Util qw(looks_like_number);

foreach (@ARGV) {
    print "$_";
    if (!looks_like_number($_)) {
	print " does not look like a number\n";
	next;
    }
    my $aVal = $_;
    while($aVal != 1) {
	if ($aVal % 2 == 0) {
	    $aVal /= 2;
	} else {
	    $aVal = 3 * $aVal + 1;
	}
	print " $aVal";
    }
    print "\n";
}
