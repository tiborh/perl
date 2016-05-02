#!/usr/bin/perl -w

use strict;

my $test_str = "the/name/to/examine/";

print $test_str."\n";

print substr($test_str,-1)."\n";
print substr($test_str,-1,1,'')."\n";

print $test_str."\n";
