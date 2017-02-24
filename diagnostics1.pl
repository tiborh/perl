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

say &send_error() ? "success" : "failure";

sub send_error() {
    # croak or die results in "uncaught exception"
    my $var1 = shift || croak "First argument is missing.";

    return $var1 ? 1 : 0;
}
