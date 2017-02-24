#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
use diagnostics;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

say &send_warning() ? "success" : "failure";

sub send_warning() {
    my $var1 = shift;
    carp "First argument is missing." unless($var1);

    say("\$var1: ", $var1 ? "defined" : "undefined");

    return $var1 ? 1 : 0;
}
