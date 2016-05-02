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
use firstClass;

my $min_required_version = 0.0.3;
firstClass->VERSION($min_required_version);

my $testInst0 = firstClass->new(qw(name joe age 23 writable 12.32));
my $testInst1 = firstClass->new();
my $testInst2 = firstClass->new();

$testInst0->testMethod();
print "name: ",$testInst0->name,"\n";
print "age: ",$testInst0->age,"\n";
print "writable: ",$testInst0->writable,"\n";
$testInst0->testMethod2(qw(一 二 三 四 五 六 七 八 九 十));

print "Default values:\n";
print "name: ",$testInst1->name,"\n";
print "age: ",$testInst1->age,"\n";
print "writable: ",$testInst1->writable,"\n";

print "Giving value to 'writable'.\n";

# this one will not work:
# $testInst1->writable = "new value"; 

# the correct way to do it:
$testInst1->writable("new value");
print "writable: ",$testInst1->writable,"\n";
