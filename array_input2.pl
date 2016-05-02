#!/usr/bin/perl -w

use strict;

my @input_array = <stdin>;
print scalar reverse $_ foreach (reverse @input_array);
print "\n";
