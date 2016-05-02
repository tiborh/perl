#!/usr/bin/perl -w

use strict;

print "The first argument is handled as a string,\n the second as a string multiplier.\n";
die "not enough arguments\n" if (scalar(@ARGV) < 2);

my $theString = $ARGV[0];
my $strLength = length($theString);
my $randIndex = 0;
printf("Length: %d\n",$strLength);
die "second argument is not a number\n" unless ($ARGV[1] =~ /^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?$/);
my $theMultiplier = $ARGV[1];
print "$theString\n" if ($theMultiplier >= 1);
my $replDirection = 0;
my $tempString = "";
for (1..$theMultiplier-1) {
    $randIndex = int(rand($strLength));
    if ($strLength > 1) {
	$replDirection = ($strLength/2 > $randIndex) ? 1 : -1;
	$tempString = substr($theString,$randIndex,1);
	substr($theString,$randIndex,1,substr($theString,$randIndex+$replDirection,1));
	substr($theString,$randIndex+$replDirection,1,$tempString);
	die "Reversed string by random: $theString (in $_ steps)\n" if ($theString eq reverse($ARGV[0]));
    }
    print "$theString\n";
}

