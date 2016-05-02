#!/usr/bin/perl -w
use strict;

my $the_dir = "./";

opendir(my $dh, $the_dir) or die $!;

foreach (readdir($dh)) {
    print $_."\n";
}

closedir $dh;
