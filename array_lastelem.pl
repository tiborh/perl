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

my @test_array = qw(一 二 三 四 五 六 七 八 九 十);

print $test_array[-1];
