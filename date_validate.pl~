#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;

my $timenow = localtime(time());
print("time now: $timenow\n");

print "No valid date entry as arg (yyy-mm-dd)\n" unless scalar(@ARGV);

foreach my $datestring (@ARGV)
{
    my $t = Time::Piece->strptime($datestring, "%Y-%m-%d");
    print "time entry: ",$t,"\n";

    my $diff = $timenow - $t;
    print "Num of days btw now and time entry: ",int($diff->days), " \n";
}

