#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

my $DEBUG = 0;

if (scalar(@ARGV) < 1)
{
    printf("%s was called with %d number of arguments. You need at least one.\n",$0,scalar(@ARGV));
    exit(1);
}

foreach (@ARGV)
{
    my $number = $_;
    printf("Factors of %d: ",$number);
    printf("number: %d\n",$number) if($DEBUG);
    for (my $factor = 2; $factor <= $number; $factor++)
    {
	printf("\tfactor: %d\n",$factor) if($DEBUG);
	while ($number % $factor == 0){
	    printf("%d ",$factor);
	    $number = $number / $factor;
	}
	
    }
    print("\n");
}

#for (int factor = 2; factor <= number; factor++)
