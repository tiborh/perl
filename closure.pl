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

my $testSampleClusure = &sampleClosure("Name","Hobby");
$testSampleClusure->("Joe","Golf");
$testSampleClusure->("Jane","Game");
$testSampleClusure->("Fred","Dread");

sub sampleClosure {
    my $var1 = shift;
    my $var2 = shift;
    
    return(sub {
	my $val1 = shift;
	my $val2 = shift;
	say "$var1: $val1";
	say "$var2: $val2";})
}
