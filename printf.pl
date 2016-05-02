#!/usr/bin/perl -w

use strict;

#to demonstrate %g

my $string = "string segment";
my $integer = 78;
my $float = 43.98;
my $large_num = 120 ** 25;

# %g is only for numbers.
printf("The string segment: %s(EOL)\n",$string);
printf("The integer: %g(EOL)\n",$integer);
printf("The float: %g(EOL)\n",$float);
printf("The large number: %g(EOL)\n",$large_num);
