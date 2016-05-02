#!/usr/bin/perl -w

use strict;

print "File does not end with an empty line.\n" if (!&main);

sub main {
    my $buffer_line = "";

    while(<STDIN>) {
	$buffer_line = $_;
    }

    return ($buffer_line =~ /(\n$)|(^\s*$)/) ? 1 : 0;
}
