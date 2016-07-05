#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

# use Text::CSV;
use diagnostics;
use Text::ParseWords;

binmode(STDOUT, ":utf8");

while (<>) {
    chomp();
    my @fields = &quotewords( ';', 0, $_ )
	or ( warn "a problem on line $.:$_" );
    print "|$_|\t" foreach (@fields);
    print "\n";
}


