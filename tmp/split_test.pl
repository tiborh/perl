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

my $teststring = "2016-12";
my $sep = "-";
my @testarr = split /$sep/,$teststring;
say "split ends: @testarr";
say "length of array: ", scalar(@testarr);
