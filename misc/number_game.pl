#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

print "1. input integer must be between 1 and 100\n";
print "2. program exits if number is out of range\n";
print "3. untested behaviour for non-integers\n";

while(<>)
{
    last if ($_ < 1 || $_ > 100);
    my $num = $_;
    $num+=3;
    printf("\tadd 3: %d\n",$num);
    $num*=2;
    printf("\tmultiply by 2: %d\n",$num);
    $num-=8;
    printf("\tsubstract 8: %d\n",$num);
    $num/=2;
    printf("\tdivide by 2: %d\n",$num);
}
