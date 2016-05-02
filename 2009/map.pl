#!/usr/bin/perl -w

@Words = ("Alpha","bEta","gaMma","delTa","EPSiLON");

$, = " ";

print "the initial state: @Words\n";

print "modified with map(ucfirst()):", map(ucfirst($_),@Words), "\n";

print "modified with map(ucfirst(lc())):", map(ucfirst(lc($_)),@Words), "\n";

