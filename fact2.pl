#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
use diagnostics;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

my $res = &factorial($ARGV[0]);
say "$ARGV[0]! == ",$res if $res;

sub factorial {
    my $n = shift // croak "null value for argument"; #  || reacts on 0 (zero) too, // skips that
    say "val in factorial(): ",$n;
    return 1 if $n == 0;
    return $n * &factorial($n-1);
}
