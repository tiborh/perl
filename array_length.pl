#!/usr/bin/perl -w

use strict;

my @sample = qw(one two three four five);

print "@sample\n";
#array in scalar context gives the size of the array:
printf("Size of the array: %d\n",scalar(@sample));
#the $# gives the index of the last element:
printf("The index of the last element: %d (\$array[%d] = %s)\n",$#sample,$#sample,$sample[$#sample]);
#but the -1 index can also be used to show the last element:
printf("The last element [-1]: %s\n",$sample[-1]);
