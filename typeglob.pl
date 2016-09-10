#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

$main::sample = 23;
@main::sample = qw/1 2 3/;
%main::sample = qw/1 一 2 二 3 三/;
sub sample {
    return "sample sub";
}

say '$main::sample == ',$main::sample;
say '@main::sample == ',"@main::sample";
say '%main::sample == ',%main::sample;
say '&sub == ',&sample();

say '*sample == ',*sample;

*sampcpy = *sample;
say '*sampcpy == ',*sampcpy;
say '$main::sampcpy == ',$main::sampcpy;

say '*sample{SCALAR} == ',*sample{SCALAR}; # reference
say '*sample{ARRAY} == ',*sample{ARRAY};
say '*sample{HASH} == ',*sample{HASH};
say '*sample{CODE} == ',*sample{CODE};
say '&{*sample{CODE}} == ',&{*sample{CODE}};
