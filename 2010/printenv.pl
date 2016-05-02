#!/usr/bin/perl -w

use strict;

my $keylength = 0;

foreach (keys(%ENV)) {
    if (length($_)>$keylength) {
	$keylength = length($_);
    }
}

foreach (sort(keys(%ENV))) {
    printf("%-${keylength}s %s\n",$_.":",$ENV{$_});
}
