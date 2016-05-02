#!/usr/bin/perl -w

use strict;

&main;

sub main {

my %fib_num = ();

die "Usage: $0 <nth member of the Fibonacci numbers>" if (@ARGV < 1);
die "Number cannot be smaller than zero." unless $ARGV[0] > 0;

while ($_ = shift @ARGV) {
    printf "%d: %d\n", $_,&fib($_);
}

exit 0;
}

sub fib {
    my $num = shift;
    return 0 if $num == 1;
    return 1 if $num == 2;
    return fib($num - 1) + fib($num - 2);
}
