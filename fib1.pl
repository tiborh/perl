#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;

binmode(STDOUT, ":utf8");

my $res = &fibonacci($ARGV[0]);
say "fibonacci($ARGV[0]) == ",$res if $res;

sub fibonacci {
    my $n = shift // croak "null value for argument"; #  || reacts on 0 (zero) too, // skips that
    return 1 if ($n == 0 || $n == 1);
    return fibonacci($n-1) + fibonacci($n-2);
}
