#!/usr/bin/perl -w

use strict;

my $sample_txt = "Bring a bringer to bringtown with good upbringing.";
my @match_array = ($sample_txt =~ m/\w*[Bb]ring\w*/g);

print "Multiple match:\n";
&print_results(@match_array);

@match_array = ($sample_txt =~ m/\ban?\b/g);

print "Single match:\n";
&print_results(@match_array);

sub print_results {
    my @match_array = @_;

    print "\tMatches: @match_array\n";
    printf "\tNumber of matches: %d\n",scalar(@match_array);
}
