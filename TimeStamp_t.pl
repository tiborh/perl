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

use TimeStamp;

my $secs = exists($ARGV[0]) ? $ARGV[0] : 5;
my $ts = new TimeStamp();
say "Timestamp: ",$ts->getter();
say "using _print_self: ";
$ts->_print_self();
say "Going to sleep for $secs seconds.";
sleep $secs;
$ts->setter();
say "Timestamp: ",$ts->getter();

say ("Testing object-free solution: ",TS::ts());
