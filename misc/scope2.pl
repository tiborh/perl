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

{
    my $x = 10;			# local
    sub getx {			# global
	print "x == $x\n";
    }
    sub setx {			# side effect
	$x = shift;
	print "x has been set to $x\n";
    }
}

#print $x,"\n";			# leads to error
&getx();			# $x existed at its definition
&setx(3);			# in that scope $x can be changed
&getx();			# $x has been set to a different value
