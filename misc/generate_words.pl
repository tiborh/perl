#!/usr/bin/perl -w

use strict;

my $wl = 0;			# word length
my $nw = 10;			# number of words

for (my $i=0;$i<$nw;$i++) {
    $wl = 1+int(rand(13));
    printf("%s\n",&gen_word($wl));
}

sub gen_word {
    my $gword = "";
    for (my $i = 0; $i < $_[0]; $i++) {
    $gword .= sprintf("%c",97+int(rand(26)));
    }
    return $gword;
}
