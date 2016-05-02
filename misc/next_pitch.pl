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

print next_pitch(),"\n" for(1..10);

sub next_pitch {
    state $scale = ["A" .. "G"];
    state $note = -1;
    return $scale->[ ($note += 1) %= @$scale ];
}