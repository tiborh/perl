#!/usr/bin/env perl

use TrRecord;

my $to = new TrRecord(
    "AA10000",
    "A",
    "fi",
    "cxp 123 456",
    "r1a",
    "test package",
    "ceadev",
    "2000-01-02",
    "2000-01-02",
    "2000-01-02",
    "cemaint"
    );

print "printing eriref: $to->{'eriref'}\n\n";
$to->print_self();


my $to1 = new TrRecord(
    "AA10000",
    "c",
    "pr",
    "cxp 123 456",
    "r1a",
    "test package",
    );

print "printing eriref: $to1->{'mhodate'}\n\n";
$to1->print_self();
