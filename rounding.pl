#!/usr/bin/perl -w

use strict;
use POSIX;

my $float_num = 3.5;

print "original:\t",$float_num,"\n";
print "ceiling:\t",ceil($float_num),"\n";
print "floor:\t\t",floor($float_num),"\n";
