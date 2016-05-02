#!/usr/bin/perl -w

use strict;

my %coll_hash = ();
my $int_runs = 1000000; 

for my $i (1..$int_runs) {
    $coll_hash{flip()}++;
}

foreach my $i (keys %coll_hash) {
    printf "%d => %d (%5.2f%%)\n",$i,$coll_hash{$i},($coll_hash{$i}/$int_runs)*100;
}

sub flip {
    return int(rand(2));
}
