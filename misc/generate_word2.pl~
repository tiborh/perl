#!/usr/bin/perl -w

use strict;

print("word length: ");
while(<STDIN>) {
    printf("%s\n",&gen_word($_));
}

sub gen_word {
    my $gword = "";
    for (my $i = 0; $i < $_[0]; $i++) {
    $gword .= sprintf("%c",97+int(rand(26)));
    }
    return $gword;
}
