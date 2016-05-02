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

use Chart::Lines;

my $obj = Chart::Lines->new (600,400);

# my %hash = ('title' => 'Foo Bar');
# $obj->set (%hash);
$obj->set ('title' => 'Foo Bar');

my $labels = ["one", "two", "three"];
$obj->set ('legend_labels' => $labels);

my @data = ( [ 'foo', 'bar', 'junk' ],
	     [ 30.2,  23.5,  92.1   ],
	     [ 12.3, 15.5, 17.7],
	     [ 50.1, 40.0, 20.9]);

$obj->png ("second.png", \@data);

