#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
#use strict;
use Carp;
use utf8;
use encoding 'utf8';
use autodie;
#use Modern::Perl;
#use Test::More;
use Date::Calc;

my %cmd_args = ();
my $this_time = time();
my @this_gmtime = gmtime($this_time);
my @date_calc_today = Date::Calc::Today([gmtime($this_time)]);

$cmd_args{$_}++ foreach (@ARGV);

&help() if (exists($cmd_args{'-h'}) or exists($cmd_args{'--help'}));

if (exists($cmd_args{'-a'}) or exists($cmd_args{'--all'})) {
    print "time(): $this_time\n";
    print "gmtime(time()): @this_gmtime\n";
    print "Date::Calc::Today([gmtime()]): @date_calc_today\n";
}

my ($week_number,$this_year) = Date::Calc::Week_Number(@date_calc_today);
print "week $week_number\n";

sub help {
    print "Usage:\n";
    print "\t$0 (without arguments): returns current week number\n";
    print "\t-a or --all: also returns extra info\n";
    print "\t-h or --help: displays usage information\n";
}


