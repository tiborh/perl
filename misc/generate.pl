#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

die "One non-negative integer is needed" if scalar(@ARGV) != 1;
&generate($ARGV[0]);
print("\n");

sub generate()
{
    my $x = shift;

    print($x % 10);
    print(" (#1: x == ",$x, "; x % 10 == ",$x % 10,")\n");
    if (int($x / 10) != 0) {
        &generate(int($x / 10));
    }
    print($x % 10);
    print(" (#2: x == ",$x, "; x % 10 == ",$x % 10,")\n");
}

