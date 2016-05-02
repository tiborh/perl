#!/usr/bin/env perl

use warnings;
#use v5.14; 			# implies strict
#use Carp;
use utf8;
#use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

print "checking package vars:\n";
my $myLex = 1;			# the only one that does not get into the symbol table
our $myLex2 = 2;
$main::xvar = 3;
local $localvar = 4;
print "check_vars:\n";
&check_vars;
print "list_module:\n";
&list_module;

sub check_vars {
    foreach my $symname (sort keys %main::) {
	local *sym = $main::{$symname};
	print "\$$symname is defined\n" if defined $sym;
	print "\@$symname is non-nul\n" if @sym;
	print "\%$symname is non-nul\n" if %sym;
    }
}

sub list_module {
    no strict 'refs';
    print "keys in main:\n";
    print "\t",$_,"\n" foreach (keys %::);
}
