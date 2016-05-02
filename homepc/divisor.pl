#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

my $num = 13 * 7 * 23;
my $a = 1;
while ($a <= $num/2) {
    if ($num % $a == 0) {
        print($a + " ");
    }
}
print("\n");
