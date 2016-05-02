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

use Chart::Bars;

my $obj = Chart::Bars->new (600,400);

# my %hash = ('title' => 'Foo Bar');
# $obj->set (%hash);
$obj->set ('title' => 'Foo Bar');

my $labels = ["one"];
$obj->set ('legend_labels' => $labels);

my @data = ( [ 'foo', 'bar', 'junk' ],
	     [ 30.2,  23.5,  92.1   ] );

$obj->png ("first.png", \@data);

