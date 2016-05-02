#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
#use strict;
use Carp;
use utf8;
#use encoding 'utf8';
use autodie;
#use Modern::Perl;
#use Test::More;

my @a_list = ();

print "empty list: '@a_list'\n";
printf("length of empty list: %d\n",@a_list);
