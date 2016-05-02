#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;
use POSIX qw(strftime);

print "No valid date entry as arg (yyy-mm-dd)\n" unless scalar(@ARGV);

foreach my $datestring (@ARGV)
{
    my $t = Time::Piece->strptime($datestring, "%Y-%m-%d");
    print "time entry: ",$t,"\n";
    print "using time::Piece variables: ",$t->fullday,", ",$t->mday," ", $t->fullmonth, " ", $t->year,"\n";
}

