#!/usr/bin/perl -w

use strict;

&main;

sub main() {
    &cmp_by_char("one","noe");
}

sub cmp_by_char() {
    my $string1 = shift(@_);
    my $string2 = shift(@_);

    print $string1,"\n";
    for (0..(length($string1))-1) {
	print((substr($string1, $_, 1) eq substr($string2, $_, 1)) ? "^" : " ");	
    }
    print "\n";
    print $string2,"\n";
}
