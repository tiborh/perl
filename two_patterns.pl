#!/usr/bin/perl -w

use strict;

my $str_search1 = "heaven";
my $str_search2 = "hell";

if (scalar @ARGV > 1) {
    $str_search1 = $ARGV[0];
    $str_search2 = $ARGV[1];
}

while(<STDIN>) {
    if(/$str_search1/i && /$str_search2/i) {
	print;
    }
}

# Two ways were mentioned in the book:
# a.) if (/search_pattern1/) {
#        if (/search_pattern2/) {
#          print;
#        }
#     }
# b.) if (/pattern1.*pattern2|pattern2.*pattern1/)
# which is plain ugly. 
# But a combination of the latter with back reference 
# would make an interesting experiment.
