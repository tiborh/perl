#!/usr/bin/perl -w

use strict;

my $match_pattern = '(<\w+(?:-\w+)?)(?:\s+[^>]+)?(>)';

my $test_line = "<gl-item><term>ASAP</term><expansion><p style='nice'>as soon as possible</p></expansion></gl-item>";
print "Test line:\n\t$test_line\n";
#this is what you get with a normal match:
if ($test_line =~ /$match_pattern/) {
    print "The contents of the match: $1$2\n";
}
if ($test_line =~ /$match_pattern/g) {
    print "If we use the 'g' option: $1$2\n";
}
# because of the above, "<gl-item>" won't be found by the match below.
my @collect_matches = ();
if (@collect_matches = $test_line =~ /$match_pattern/g) {
    print "If the result is collected in an array: @collect_matches\n";
}
