#!/usr/bin/env perl

use warnings;
use strict;
#use Modern::Perl;
use Carp;

print "wantarray() returns:\n";
print "\tin void context: ";
&test_context();
print "\tin scalar context: ";
my $testvar = &test_context();
print "\tin array context: ";
my @testarray = &test_context();

sub test_context {
    my $output = wantarray();
    print defined($output) ? "'$output'" : "'undef'";
    print "\n";
    return undef;
}
