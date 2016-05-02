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

sub PI () { 4 * atan2(1,1); }	# inlined function

# calling a function:

say "PI: ", PI;

f0("one","two","three");	# before declaration

sub f0 {
    say 'length of @_: ',scalar(@_);
    say "elements:";
    say "\t",$_ for (@_);
    return 0;
}

f0 "one","two","three";		# after declaration
&f1("one","two","three");	# overrides prototypes

sub f1($) {
    f0 @_;
    return 1;
}

say f1 "one","two","three"; 	# Only first arg is taken.

my @foo = ("一","二","三");

f0 @foo;			# three elements
f1 @foo;			# in scalar context

sub f2 : lvalue {
    state $x = 0;
    $x = $_[0] if scalar(@_) > 0;
    return $x;
}

say f2;				# initialised
say f2 = 5;			# memory filled up
say f2;				# memory retrieved

sub f3 {
    my $glob = shift or return;
    say "You gave me: ",*{$glob}{PACKAGE}, "::", *{$glob}{NAME};
}

f3;				# nothing
local *myglob;
*myglob = \&PI;
f3 *myglob;

use typeglob;
f3 *MyGlob::myGlob;
say ${*MyGlob::myGlob{SCALAR}} || $MyGlob::myScal;
say *MyGlob::myGlob{ARRAY} || @$MyGlob::myArr;
say *MyGlob::myGlob{HASH} || %$MyGlob::myHash;
say *MyGlob::myGlob{CODE} || &MyGlob::myCode;
say *MyGlob::myGlob{GLOB};
