#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

my $t = time();
say "Time in secs: $t";
my $lt = localtime($t);
say "In localtime: ",$lt;
$t -= 15 * 7 * 24 * 60 * 60;
say "After subtracting 15 weeks: $t";
$lt = localtime($t);
say "In localtime: ",$lt;
use DateTime;
my $dt = DateTime->from_epoch( epoch => $t );
say "DateTime: $dt";
my $isodate = sprintf "%4d-%02d-%02d",$dt->year,$dt->month,$dt->day;
say "ISO date $isodate";
