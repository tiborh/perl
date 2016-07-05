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

use Term::ReadKey;
print "Type your password: ";
ReadMode('noecho'); # don't echo
chomp(my $password = <STDIN>);
print("\n");
print "Re-type your password: ";
chomp(my $password_check = <STDIN>);
print("\n");
say $password eq $password_check ? "match" : "no match";
ReadMode(0);        # back to normal
