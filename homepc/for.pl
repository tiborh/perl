#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

sub m()
{
    my $x = shift;
    my $y = shift;
    my $z = 0;
    for (my $i=1; $i<=$y; ++$i)
    {
	$z = $z + $x;
	print($i,$i<=$y ? " true " : " false ",$z,"\n");
    }

    return $z;
}

my $z = &m(2,3);
print($z,"\n");
