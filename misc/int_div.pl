#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

die "Two positive integer arguments are needed." if scalar(@ARGV) != 2;
die "Positive numbers are needed." if ($ARGV[0] <= 0 or $ARGV[1] <= 0);
print(&intDiv(@ARGV),"\n");

# Returns the quotient of an integer division 
# @param dividend a positive int
# @param divisor a positive int

sub intDiv(){
    my $dividend = shift;
    my $divisor = shift;
    
    return 0 if $dividend < $divisor;

    my $tmp = $dividend - $divisor;

    return(1 + &intDiv($tmp,$divisor));
}
