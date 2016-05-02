#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

use SimplestChild;
my $CLASS_TO_TEST = "SimplestChild";

my $to = new $CLASS_TO_TEST;
say "version: ",$to->VERSION;
say "Object ID: ", $to->getID();
say "ref: ",ref $to;
say "UNIVERSAL test:";
say "\tisa($CLASS_TO_TEST): ",$to->isa($CLASS_TO_TEST) ? "true" : "false";
say "\tcan('getID'): ",$to->can("getID") ? "true" : "false";
say "\tcan('printSelf'): ",$to->can("printSelf") ? "true" : "false";
say "\tDOES('callPrivate'): ",$to->DOES("callPrivate") ? "true" : "false"; # implemented in Moose or Role::Tiny
say "\tVersion ",$to->VERSION();
eval { 
    say "\tMin needed version v0.0.2, has: ",$to->VERSION('v0.0.2');
}; carp "\t$@" if $@;

$to->callPrivate();

my $N_MINUS_ONE = 2;
say "Creating ",$N_MINUS_ONE+1," objects";
my @tos = ();
push @tos,new $CLASS_TO_TEST for (0..2);
say "\tObject with ID == ",$_->getID(),$_->callPrivate()," has been created." for (@tos);

use test_package;

TestPackage::list_package_vars($CLASS_TO_TEST);

