#!/usr/bin/perl -w

use strict;

my @the_lines = ();
my @one_line = ();
my @stripped_line = ();

while (<STDIN>) {
    chomp;
    @one_line = split /\t/, $_;
    foreach my $line (@one_line) {
	$line =~ s/"([^"]*)"/$1/g;
	$line =~ s/\s+$//;
	$line =~ s/^\s+//;
	push(@stripped_line,$line);
    }
    push @the_lines, [@stripped_line];
    # other alternatives:
    # @the_lines[$i] = [@stripped_line];
    # @{$the_lines[$i]} = @stripped_line;
    @stripped_line = ();
}

for my $i (0..$#the_lines) {
    for my $j (0..$#{$the_lines[$i]}) {
	printf(($j ? "%-25s" : "%-10s"),$the_lines[$i]->[$j]); # ${$the_lines[$i]}[$j]
    }
    print "\n";
}
