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

my $testSampleClusure = &sampleClosure("one","two");
$testSampleClusure->("one","two");
$testSampleClusure->();
$testSampleClusure->("three","four");

sub sampleClosure {
    my $name = shift;
    my $hobby = shift;
    
    return(sub {
	say "input: '@_'";
	say "My name: $name";
	say "My hobby: $hobby";})
}
