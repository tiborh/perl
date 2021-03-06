#!/usr/bin/perl -w

use strict;

&main;

sub main {

my %fib_num = ();

die "Usage: $0 <nth member of the Fibonacci numbers>" if (@ARGV < 1);
die "Number cannot be smaller than zero." unless $ARGV[0] > 0;

my $n = $ARGV[0];

printf "Returned value: %d\n",&fibonacci($n,\%fib_num);
print " $fib_num{$_}" foreach (sort {$a <=> $b} keys %fib_num);
print "\n";

exit 0;
}

sub fibonacci {
  my $a = 0;
  my $b = 1;
  my $n = $_[0];

  for (1..$n){
      ${$_[1]}{$_} = $a unless (exists ${$_[1]}{$_});
      ($a, $b) = ($b, ($a + $b));
  }
  return ${$_[1]}{$n};
}
