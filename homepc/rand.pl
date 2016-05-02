#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $text = "I can't understand it. I can't even understand the people who can understand it.";

print "the original text:\n I can't understand it. I can't even understand the people who can understand it.";

foreach (1..10) {
    my $salt = join '', ('.', '/', 0..9, 'A'..'Z', 'a'..'z')[rand 64, rand 64];
    my $encrypted_text = crypt $text, $salt;
    printf "The random salt: %s\n", $salt;
    printf "The encrypted text: %s\n", $encrypted_text;
    sleep 1;
}
