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

package main;

$main::name = "data";
our $name;

say '$name: ',$name;
{
    no strict 'refs';
    ${$name} = "my data";
    say '${$name}: ',${$name};
}

# say "keys of the symbol table: ";
# say "\t$_" foreach keys %main::;

say 'does $main::name exist? ',exists($main::{name}) ? "yes" : "no";
say 'does $main::data exist? ',exists($main::{data}) ? "yes" : "no";
say 'value of $main::data: ',$main::data;
