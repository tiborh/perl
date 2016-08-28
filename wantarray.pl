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

my @results = &test_wantarray();
say "results: @results";
my $result = &test_wantarray();
say "result: $result";
&test_wantarray();

sub test_wantarray() {
    my @vals = (1,2,3);
    return @vals if wantarray(); # 1 in list context
    return scalar(@vals) if defined(wantarray()); # defined but no value in scalar context
    carp("&test_wantarray() was called in null context"); # undefined in null context
}
