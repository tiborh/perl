#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

use simplest6;

my $to = new Simplest;
#say "version info: ",$Simplest::VERSION;
say "Version ",$to->version();
say "ID: ", $to->getID();
say "ref: ",ref $to;
$to->callPrivate();

my @tos = ();
push @tos,new Simplest for (0..2);
say "Object with ID == ",$_->getID(),$_->callPrivate()," has been created." for (@tos);

use test_package;

TestPackage::list_package_vars("Simplest");

