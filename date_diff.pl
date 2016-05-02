#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;

my $t = Time::Piece->strptime("2011-11-21", "%Y-%m-%d");
print $t->strftime("%w\n");
print $t,"\n";

my $timenow = localtime(time());
print("time now: $timenow\n");

my $diff = $timenow - $t;
print "Num of days btw the 2: ",int($diff->days), " \n";
