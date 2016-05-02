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

my $number = (scalar(@ARGV) == 0) ? 100 : $ARGV[0];

my $counter = 0;

for (1..$number)
{
    ++$counter if ((&roll_die() + &roll_die()) > 8);
}

print("percent: ",($counter/$number)*100,"\n");

sub roll_die()
{
    my $sides = (scalar(@_) == 0) ? 6 : $_[0];
    
    return int(rand($sides))+1;
}
