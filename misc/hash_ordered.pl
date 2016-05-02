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

# simple interfacem
my $t = tie(my %myhash, 'Tie::IxHash', 'a' => 1, 'b' => 2);
%myhash = (first => 1, second => 2, third => 3);
$myhash{fourth} = 4;
say "t: ",$t;
my @keys = keys %myhash;
say "keys: @keys";
my @values = values %myhash;
say "values: @values";
say("Does 'third' exist as key? y") if exists $myhash{third};
say("keys of t: ",$t->Keys());
my $mp = \%myhash;
say "reference to myhash: ",ref($mp);
say("accessing value of 'third' via reference syntax: ",$mp->{third});

# OO interface
$t = Tie::IxHash->new(first => 1, second => 2, third => 3);
$t->Push(fourth => 4); # same as $myhash{'fourth'} = 4;
my ($k, $v) = $t->Pop;    # $k is 'fourth', $v is 4
$t->Unshift(neg => -1, zeroth => 0); 
($k, $v) = $t->Shift;  # $k is 'neg', $v is -1
my @oneandtwo = $t->Splice(1, 2, foo => 100, bar => 101);

@keys = $t->Keys;
@values = $t->Values;
my @indices = $t->Indices('foo', 'zeroth');
my @itemkeys = $t->Keys(@indices);
my @itemvals = $t->Values(@indices);
$t->Replace(2, 0.3, 'other');
$t->Delete('second', 'zeroth');
my $len = $t->Length;     # number of key-value pairs

$t->Reorder(reverse @keys);
$t->SortByKey;
$t->SortByValue;
