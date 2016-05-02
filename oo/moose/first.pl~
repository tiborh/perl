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

my $min_required_version = 0.0.2;
firstClass->VERSION($min_required_version);

my $testInst0 = firstClass->new();
my $testInst1 = firstClass->new();
my $testInst2 = firstClass->new();

$testInst0->testMethod();
$testInst1->testMethod();
$testInst2->testMethod() for 0..2;

