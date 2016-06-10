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

use POSIX qw(strftime);
use Time::Piece;

#my @now = localtime();
my $now_date = strftime("%Y-%m-%d",localtime);
say "today: $now_date";
my $lt = Time::Piece->strptime($now_date, "%Y-%m-%d");
my $currweek = $lt->strftime("%W");

my $timestring = $ARGV[0] || "2016-05-11";

my $t = Time::Piece->strptime($timestring, "%Y-%m-%d");
my $thenweek = $t->strftime("%W");

say "Week difference from then till now: ", $currweek-$thenweek;

say "Year_week: ",$t->strftime("%Y_%W");
