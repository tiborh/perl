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

use Bug;

my $aBug = Bug->new("001","minor","A small issue");
$aBug->print_me();

my $bugF = Bug->new("002","fatal","A fatal issue");
$bugF->print_me();
