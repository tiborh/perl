#!/usr/bin/env perl

use warnings;
use strict;
#use Modern::Perl;
use Carp;
use utf8;
use encoding 'utf8';

&some_function(one => "datum");
&another_function(four => "datum");
&defined_function(1,2,3,"string");

sub defined_function() {
    sub another_function() {
	print "another_function() inside defined function\n";
	print "parameters: @_\n" if defined(@_);
    }

    print "I'm a defined function.\n";
    print "parameters: @_\n" if defined(@_);
    &some_function(two => "datum");
    &another_function(three => "datum");
}

sub AUTOLOAD() {
    our $AUTOLOAD;
    my @caller_array = caller();
    print "$AUTOLOAD() is a dummy function.\n";
    print "(caller: @caller_array)\n";
}
