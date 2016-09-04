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

use lib "/home/tibor/repos/perl/lib";
use sample::Sample '0.0.1';	# good

&Sample::SaySomething();
&Sample::SaySomethingElse("one","two","three");
