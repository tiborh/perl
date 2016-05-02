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
my @the_result = &intDiv(@ARGV);
print("Quotient:\t$the_result[0]\nRemainder:\t$the_result[1]\n");

# Returns the quotient of an integer division 
# @param dividend a positive int
# @param divisor a positive int

sub intDiv(){
    my $dividend = shift;
    my $divisor = shift;
    my @result = (0,$dividend);	# [0] quotient, [1] remainder
    
    if ($dividend < $divisor)
    {
	return(@result);
    }
    else
    {
	my @tmp = &intDiv($dividend - $divisor,$divisor);
	$result[0] = 1 + $tmp[0];
	$result[1] = $tmp[1];

	# another way:
	# my $tmp = $dividend - $divisor;
	# $result = &intDiv($tmp,$divisor);
	# $result[0]++;

	return(@result);
    }
}
