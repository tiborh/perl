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
use mySimple;

binmode(STDOUT, ":utf8");

my $min_required_version = 0.0.2;
mySimple->VERSION($min_required_version);

my $testVar = mySimple->new(qw(1 一 2 二 3 三 4 四 5 五));

print "Return value without parameters: ";
if (defined($testVar->doIt())) {
    print "defined\n";
} else {
    print "undefined\n";
}

print "Return value with existing parameter: ";
print $testVar->doIt("1"),"\n";

print "Return value with non-existing parameter: ";
if (defined($testVar->doIt("6"))) {
    print "defined\n";
} else {
    print "undefined\n";
}

$testVar->print();
