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

for (my $i=0;$i<scalar(@the_lines);$i++) {
    print "@{$the_lines[$i]}\n";
}

print "\n" x 2;

for (my $i=0;$i<scalar(@the_lines);$i++) {
    for (my $j=0;$j<scalar(@{$the_lines[$i]});$j++) {
	printf(($j ? "%-25s" : "%-10s"),$the_lines[$i]->[$j]); # ${$the_lines[$i]}[$j]
    }
    print "\n";
}
