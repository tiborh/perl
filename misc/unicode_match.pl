#!/usr/bin/env perl

use warnings;
use utf8;
#use Carp;

# needed to avoid complaints about "Wide character in print:"
binmode STDOUT, 'encoding(UTF-8)';

my $sample_utf8 = "卵は夏に腐り易い。";
my $found = ($sample_utf8 =~ /卵.夏.*/);
if ($found > 0)
{
    print "matched\n";
}
else
{
    print "unmatched\n";
}

print "found: $found\n";
