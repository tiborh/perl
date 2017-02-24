#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;

binmode(STDOUT, ":utf8");

my $res = &factorial($ARGV[0]);
say "$ARGV[0]! == ",$res if $res;

sub factorial {
    my $n = shift || return;	# error with zero
    return 1 if $n == 0;
    return  $n * factorial($n-1);
}
