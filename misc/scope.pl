#!/usr/bin/perl -w

#use strict;

my $maxArr = 10;
my $maxRand = 1000;
my @array;

for (my $i =0; $i < $maxArr; $i++) {
    $array[$i] = int(rand($maxRand));
}

print("The array: @array\n");
print( defined($i) ? "i = $i" : '$i is not defined outside the "for" loop.' , "\n");
