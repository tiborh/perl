#!/usr/bin/env perl

use strict;
use warnings;
use POSIX qw(strftime);
use Time::Piece;

my $inseconds = time();
my $timenow = localtime($inseconds);
my $time_in_an_hour = localtime($inseconds + 3600);
my $gmtime_in_an_hour = gmtime($inseconds + 3600);
my $tzone = strftime("%Z",localtime);

my $t = $time_in_an_hour;

print("Time now: $timenow\n");
print("Time in an hour: $time_in_an_hour $tzone\n");
print("GM Time in an hour: $gmtime_in_an_hour GMT\n");

my $expiry_time2 = sprintf("%s, %s %s %s",$t->fullday,$t->ymd,$t->hms,$tzone); # e.g. Tuesday, 31-Dec-2007 23:12:40 GMT
print("Expiry time: $expiry_time2\n");
