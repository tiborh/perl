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

say "sharing resources";

{				# to seal off $locked
    my $locked;
    sub lock{ return 0 if $locked; $locked=1; }
    sub unlock{ $locked=0 }
}

say "Is it locked? ",lock() ? "No" : "Yes";
say "lock called";
# lock() or die "Resource already in use";
# Do critical stuff…
say "Is it locked? ",lock() ? "No" : "Yes";
unlock();
say "unlock called";
say "Is it locked? ",lock() ? "No" : "Yes";
