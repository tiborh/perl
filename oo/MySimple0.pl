#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
#use strict;
use Carp;
use utf8;
#use encoding 'utf8';
use autodie;
#use Modern::Perl;
#use Test::More;
use MySimple;

binmode(STDOUT, ":utf8");

my $CLASS_TO_TEST = "MySimple";
my $min_required_version = 0.0.3;
$CLASS_TO_TEST->VERSION($min_required_version);

my $testVar = $CLASS_TO_TEST->new(qw(1 一 2 二 3 三 4 四 5 五));

say "Testing getVal()";
print "\tReturn value without parameters: ";
if (defined($testVar->getVal())) {
    print "defined\n";
} else {
    print "undefined\n";
}

my $tp = "1";
print "\tReturn value with existing parameter ($tp): ";
print $testVar->getVal($tp),"\n";

$tp = "6";
print "\tReturn value with non-existing parameter ($tp): ";
if (defined($testVar->getVal($tp))) {
    print "defined\n";
} else {
    print "undefined\n";
}

say "Testing printSelf()";
$testVar->printSelf();

use test_package;
TestPackage::list_package_vars($CLASS_TO_TEST);
