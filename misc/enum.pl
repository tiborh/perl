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

use Moose;
use Moose::Util::TypeConstraints;

eval {
    enum Gender => qw(female mail);
}; say "error: $@" if $@;

enum Gender => [qw(female mail)];

