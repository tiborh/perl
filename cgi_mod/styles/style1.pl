#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

print <<'EOF';
print "Content-type: text/css";

body {
    background-color: blue;
    color: yellow;
}
EOF
