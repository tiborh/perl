#!/usr/bin/perl -w

my @dateTime = localtime(time);
my $yearOffset = 0;

print "Unix time: ",@dateTime , "\n";
$yearOffset = $dateTime[5];
print "Year offset: ",$yearOffset , "\n";
printf "the year is: %d\n",1900 + $yearOffset;
