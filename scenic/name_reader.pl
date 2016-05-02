#!/usr/bin/perl -w

use strict;

my $fn = 'names.txt';

open(my $fh, "<", $fn) or die "cannot open < $fn: $!";

my @input_array = <$fh>;

close $fh;

print sort @input_array;

my $num_of_names = scalar @input_array;

print "Number of names: $num_of_names\n";
