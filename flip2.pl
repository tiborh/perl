#!/usr/bin/perl -w

use strict;

my %coll_hash = ();
my $int_runs = 1000000; 
my $loop_counter = 0;

for my $i (1..$int_runs) {
    my $temp = "";
    do {
	$temp = &flip();
	$coll_hash{$temp}++;
	$loop_counter++;
    } while ($temp);
}

foreach my $i (keys %coll_hash) {
    printf "%d => %d (%5.2f%%)\n",$i,$coll_hash{$i},($coll_hash{$i}/$loop_counter)*100;
}

sub flip {
    return int(rand(2));
}
