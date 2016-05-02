#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
#use strict;
use Carp;
use utf8;
#use encoding 'utf8';
use autodie;
#use Modern::Perl;
#use Test::More;

my @shapes = qw(C H Q U);
my @squares = qw(ul ur dl dr);
my @angles = qw(0 90 180 270);

my %shapes = qw(C 0 H 0 Q 0 U 0);
my %squares = qw(ul 0 ur 0 dl 0 dr 0);
my %angles = qw(0 0 90 0 180 0 270 0);

# foreach my $a_shape (sort keys %shapes) {
#     print "$a_shape => $shapes{$a_shape}\n";
# }

foreach my $a_shape (@shapes) {
    #print "\n";
    foreach my $a_square (@squares){
	print "$a_shape in $a_square\n";
	#foreach my $an_angle (@angles) {
	#    print "\t\t$an_angle\n";
	#}
    }
}
