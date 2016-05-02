#!/usr/bin/perl -w

use strict;

my $fn = 'names.txt';

open(my $fh, "<", $fn) or die "cannot open < $fn: $!";

my @input_array = <$fh>;

close $fh;

my $num_of_names = scalar @input_array;

print "Number of lines: $num_of_names\n";

my $line_nu = int(rand($num_of_names));

print "$line_nu: $input_array[$line_nu]";
