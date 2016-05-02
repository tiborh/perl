#!/usr/bin/perl -w
use strict;

{
    my $a_letter = "a";
    print $a_letter++,"\n";
    print $a_letter,"\n";
    $a_letter = "z";
    print $a_letter++,"\n";
    print $a_letter,"\n";
}

{
    my $a_word = "apple";
    print $a_word++,"\n";
    print $a_word,"\n";
}

{
    my $a_word = "零";
    print $a_word++,"\n";
    print $a_word,"\n";
}
