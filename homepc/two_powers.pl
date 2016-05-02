#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

my $k = 16;
my $result = 1;
while ($k > 0){
    $result = $result * 2;
    print("2^",(16 - $k +1),"==",$result,"\n");
    --$k;
}
