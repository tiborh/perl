#!/usr/bin/perl -w

use strict;

my $str_search1 = "heaven";
my $str_search2 = "hell";

if (scalar @ARGV > 1) {
    $str_search1 = $ARGV[0];
    $str_search2 = $ARGV[1];
}

# slightly modified version of the book sample solution
# the order of the two patterns needs be indifferent
while(<STDIN>) {
    if(/(?:($str_search1).*($str_search2))|\1.*\2/i) {
	print;
    }
}
