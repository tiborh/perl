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

my $self->{aString} = sprintf("%s%02d%02d","1975","3","10");
say $self->{aString};
