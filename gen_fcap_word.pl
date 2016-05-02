#!/usr/bin/perl -w

use strict;

my $mwl = 13;		# max word length minus 1
my $cap = 0;		# if $ARGV[0] is non zero, first letter gets capitalised

if ($ARGV[0]) {
    $cap = 1;
}
printf("%s\n",&gen_word($mwl,$cap));

sub gen_word {
    my $gword = sprintf("%s",&gen_chars(1+int(rand($_[0])),$_[1]));
#    return $gword;
}

sub gen_chars {
    my $gchars = "";
    my $gchar = 0;
    for (my $i = 0; $i < $_[0]; $i++) {
	$gchar = 97+int(rand(26));
	if (($_[1]) && (!$i)) {
	    $gchar -= 32;
	}
	$gchars .= sprintf("%c",$gchar);
    }
    return $gchars;
}
