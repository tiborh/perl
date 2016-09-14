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

use BaseName;

say "get_basename(): ",&BaseName::get_basename();
say "get_basename(1): ",&BaseName::get_basename(1);
say "get_basename(2): ",&BaseName::get_basename(2);
