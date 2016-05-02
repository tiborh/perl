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

use Tie::IxHash;

# simple interface
# it does not work with references!!!
my $myhash = {};
my $t = tie(%$myhash, 'Tie::IxHash', 'a' => 1, 'b' => 2);
$myhash = {first => 1, second => 2, third => 3};
say "keys before adding a fourth: ",keys %$myhash;
$myhash->{fourth} = 4;
my @keys = keys %$myhash;
say "keys: @keys";
my @values = values %$myhash;
say "values: @values";
say("Does 'third' exist as key? y") if exists $myhash->{third};
say("keys of t: ",$t->Keys());
say "reference to myhash: ",ref($myhash);

