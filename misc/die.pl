#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

print(&roll_die() . "\n") for (1..10);

sub roll_die()
{
    my $sides = (scalar(@_) == 0) ? 6 : $_[0];
    
    return int(rand($sides))+1;
}
