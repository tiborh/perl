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
use Algorithm::Permute; 

my @shapes = qw(C H Q U);
my @copy_shapes = @shapes;
my @angles = qw(0 90 180 270);
my @copy_angles = @angles;
my @shape_permutations = ();
my @angle_permutations = ();

my $p_iterator = Algorithm::Permute->new(\@copy_shapes);
while (my @perm = $p_iterator->next) {
    push @shape_permutations, \@perm;
}
$p_iterator = Algorithm::Permute->new(\@copy_angles);
while (my @perm = $p_iterator->next) {
    push @angle_permutations, \@perm;
}

my $counter = 0;
foreach my $shape_perm_counter (0..$#shape_permutations) {
    print("@{$shape_permutations[$shape_perm_counter]}\n");
    foreach my $angle_perm_counter (0..$#angle_permutations) {
	my $printit = 1;
	foreach my $shape_counter (0..$#shapes) {
	    $printit = 0 if ($shape_permutations[$shape_perm_counter][$shape_counter] eq 'H' and ($angle_permutations[$angle_perm_counter]->[$shape_counter] eq '180' or $angle_permutations[$angle_perm_counter]->[$shape_counter] eq '270'));
	}
	printf("\t%2d: %3s %3s %3s %3s\n",$counter++,@{$angle_permutations[$angle_perm_counter]}) if $printit;
    }
}
