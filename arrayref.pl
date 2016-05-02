#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#use Modern::Perl;
#use Test::More;

my $an_array_ref = [1,2,3,4,5,6,7];
my $a_hash_ref = {1,2,3,4,5,6,7,8};

print "an_array: @$an_array_ref\n";
print "an_array:", %$a_hash_ref, "\n";
