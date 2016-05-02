#!/usr/bin/perl -w

use strict;

print "Numbers to multiply: ";
chomp(my $input = <stdin>);
my @ar_input = split/\s+/,$input;
  #$, = " ";
  #print @ar_input,"\n";
  #$" = ",";
  #print "@ar_input\n";
my $maxindex = $#ar_input;
my $product = 0;
foreach (@ar_input) {
    next unless (m/^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?$/);
    $product = 1 if ($product == 0);
    $product *= $_;
}
print "Product: $product\n";
