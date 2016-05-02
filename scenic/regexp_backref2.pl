#!/usr/bin/perl -w

use strict;

my @arr_collect = ();
my %hsh_collect = ();
my $str_match = "";
my $int_maxlen = 0;
my $int_lineNu = 0;

while (<STDIN>) {
    $int_lineNu++;
    chomp;
    if (@arr_collect = /((\w)(\w)\3\2)/g) {
	while (@arr_collect) {
	    $str_match = shift @arr_collect;
	    if (! exists $hsh_collect{$str_match}) {
		$hsh_collect{$str_match} = $int_lineNu;
	    }
	}
    }
    if ($int_lineNu == 200) {last;}
}

foreach $str_match (keys %hsh_collect) {
    if (length $str_match > $int_maxlen) {
	$int_maxlen = length $str_match;
    }
}

my $str_format = "-$int_maxlen"."s";

foreach $str_match (sort keys %hsh_collect) {
    printf("%$str_format => %s\n",$str_match,$hsh_collect{$str_match});
}
