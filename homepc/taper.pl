#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

for (my $i=3; $i>=1; $i--) {
    for (my $j=1; $j<=$i; $j++) {
        print($j, " ");
    }
    print("\n");
}
