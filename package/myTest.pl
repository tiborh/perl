#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
#use strict;
use Carp;
use utf8;
use encoding 'utf8';
use autodie;
#use Modern::Perl;
#use Test::More;
use myTest;

my $test_package_version = TestPackage->VERSION();
print "TestPackage version: $test_package_version\n";
print "Testing if too old:\n";
my $min_required_version = 0.1;
TestPackage->VERSION($min_required_version);

#wrong approach: revision is not necessarily a number
#die "TestPackage version ($test_package_version) is too old, $min_required_version or newer is needed," unless $test_package_version >= $min_required_version;
