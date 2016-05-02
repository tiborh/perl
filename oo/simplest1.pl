#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

use simplest1;

my $to = new Simplest;
#say "version info: ",$Simplest::VERSION;

use test_package;

TestPackage::list_package_vars("Simplest");

