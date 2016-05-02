#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;
use File::Basename;

binmode(STDOUT, ":utf8");

print "script name: ",$0,"\n";
print "basename: ",basename($0),"\n";
print fileparse($0),"\n";
print fileparse($0, qr/\.[^.]*/),"\n";
print fileparse($0, qr/\Q.pl\E/),"\n";
