#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

# closures are useful for either default parameters or for caching
# This one demonstrates the first:

my $man = &complement("Adam");
$man->("walking");
$man->("at home");
$man->("down");
$man->(35);

sub complement() {
    my $name = shift;
    return sub{ print "$name is ",shift,".\n"; };
}
