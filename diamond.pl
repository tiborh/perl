#!/usr/bin/perl -w

use strict;

while (<>) {
    print;
}
print "\n";

# command line arguments are interpreted as files to open and read
# no command line argument: waiting for input
# redirection "<" is handled as with <stdin>
# pipe "|" is handled the same way as unix utilities do
