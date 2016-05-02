#!/usr/bin/env perl

use warnings;
use 5.014;
use utf8;

binmode(STDOUT, ":utf8");

print "counter: ",&next_count(),"\n" for (1..5);

sub next_count() {
    state $counter = 0;		# first time only
    return $counter++;		# return and increment
}
