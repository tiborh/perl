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

print "Bit match\n";
my $pattern = 0777;
printf("My pattern: %#o\n",$pattern);
print "enter yours (<space> to exit loop):\n";
while(<>) {
    chomp;
    last if $_ eq " ";
    printf("bitmatch: %#o\n",$pattern &~ oct($_));
}
printf("umask %#o\n",umask());
printf("bitmatch for umask: %#o\n",$pattern &~ umask());
