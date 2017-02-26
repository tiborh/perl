#!/usr/bin/env perl

## a debug version: to show what is called and with what values

use warnings;
use v5.14; 			# implies strict
use Carp;
use Carp::Assert;
use utf8;
use diagnostics;

binmode(STDOUT, ":utf8");

$main::count1 = 0;
$main::count2 = 0;
$main::countCalls = 0;

my $res = &fibonacci($ARGV[0]);
say "fibonacci($ARGV[0]) == ",$res if $res;
say "fibonacci() has been called $main::countCalls times";
say "path 1 has been taken $main::count1 times";
say "path 2 has been taken $main::count2 times";
assert($main::countCalls == $main::count1 + $main::count2);

sub fibonacci {
    my $n = shift // croak "null value for argument";
    $main::countCalls++;
    if ($n == 0 || $n == 1) {
	say "path 1: n == $n";
	$main::count1++;
	return 1;
    } else {
	say "path 2: n == $n";
	$main::count2++;
	return fibonacci($n-1) + fibonacci($n-2);
    }
}
