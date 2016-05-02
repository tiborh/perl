#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

#print("number of args: ",scalar(@ARGV),"\n");

die "At least one non-negative integer is needed" if scalar(@ARGV) < 1;

&main(@ARGV);

sub main()
{
    while(@_)
    {
	my $number = shift(@_);
	my $factn = ($number > 98 ? &factit($number) : &fact($number));
	#next if $factn < 0;
	print("$number! == $factn\n"); # when last tried max num was 170, after that "inf"
    }
}

sub fact()
{
    my $number = shift;
    die "Not defined for negative nubers." if $number < 0;

    return(1) if $number == 0;
    
    return($number * &fact($number-1));
}

sub factit()
{
    my $number = shift;
    die "Not defined for negative nubers." if $number < 0;

    my $result = 1;

    return($result) if $number == 0;

    $result*= $_ for (1..$number);

    return($result);
}
