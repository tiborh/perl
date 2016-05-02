#!/usr/bin/perl -w

use strict;

my @arr_collect = ();
my %hsh_collect = ();
my $str_match = "";
my $str_maxlen = 0;

while (<STDIN>) {
    chomp;
    if (@arr_collect = /(\b\w*(?:-)?\w*(\w)(\w)\3\2\w*(?:-)?\w*\b)/g) {
	while (@arr_collect) {
	    $str_match = shift @arr_collect;
	    if (length $str_match < 2) { # why does it match single letters?
		next;
	    }
	    $hsh_collect{$str_match}++;
	}
    }
}

foreach $str_match (keys %hsh_collect) {
    if (length $str_match > $str_maxlen) {
	$str_maxlen = length $str_match;
    }
}

my $str_format = "-$str_maxlen"."s";

foreach $str_match (sort keys %hsh_collect) {
    printf("%$str_format => %s\n",$str_match,$hsh_collect{$str_match});
}
