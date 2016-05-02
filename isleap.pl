#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

print "1. input is year\n";
print "2. return value is 1 for leap year and 0 for common year\n";
print "3. use Ctrl+D to exit the program.\n";

print(&isLeap($_),"\n") while(<>);

sub isLeap()
{
    my $year = shift;
    if ($year % 4 != 0) {
	return 0;
    } elsif ($year % 100 != 0) {
	return 1;
    } elsif ($year % 400 != 0) {
	return 0;
    } else {
	return 1;
    }
}
