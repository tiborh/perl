#!/usr/bin/perl -w

use strict;

die "not enough arguments\n" if (scalar(@ARGV) < 2);

my $theString = $ARGV[0];
die "second argument is not a number\n" unless ($ARGV[1] =~ /^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?$/);
my $theMultiplier = $ARGV[1];
print "$theString\n" x $theMultiplier;
#print "\n";
