#!/usr/bin/env perl

use warnings;
use strict;
use Modern::Perl;
use Carp;

&test_caller();

sub test_caller {
    my @output = caller();
    print "The name of the calling package: $output[0]\n";
    print "The name of the file containing the call: $output[1]\n";
    print "The line number of the file on which the call occurred: $output[2]\n";
}
