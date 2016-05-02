#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

use simplest2;

my $to = new Simplest;
#say "version info: ",$Simplest::VERSION;
say "Version ",$to->version();

use test_package;

TestPackage::list_package_vars("Simplest");

