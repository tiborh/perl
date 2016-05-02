#!/usr/bin/env perl

use strict;
use warnings;
use POSIX qw(strftime);

my $inseconds = time();
my $timenow = localtime($inseconds);
my $time_in_an_hour = localtime($inseconds + 3600);
my $gmtime_in_an_hour = gmtime($inseconds + 3600);
my $tzone = strftime("%Z",localtime);

print("Time now: $timenow\n");
print("Time in an hour: $time_in_an_hour $tzone\n");
print("GM Time in an hour: $gmtime_in_an_hour GMT\n");
