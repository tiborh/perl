#!/usr/bin/perl -w

use strict;

print "input: ";
chomp(my $input = <stdin>);
#print "input: $input\n";
print $input =~ /^[-+]?\d+(?:\.\d*)?(?:[eE][-+]?\d+(?:\.\d*)?)?$/ ? 1 : 0;
print "\n";
print $input =~ /^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?$/ ? 1 : 0;
print "\n";
#print "input + 0: $input\n";
