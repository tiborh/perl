#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

use simplest4;

my $to = new Simplest;
#say "version info: ",$Simplest::VERSION;
say "Version ",$to->version();
say "ID: ", $to->getID();
$to->callPrivate();

my @tos = ();
push @tos,new Simplest for (0..9);
say "Object with ID == ",$_->getID()," has been created." for (@tos);

use test_package;

TestPackage::list_package_vars("Simplest");

