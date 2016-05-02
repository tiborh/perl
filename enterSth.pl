#!/usr/bin/perl -w

my $sthEntered;

do {
    print "Give me something to read: ";
    $sthEntered = <stdin>;
    print $sthEntered;
} while (chomp($sthEntered));
