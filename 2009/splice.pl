#!/usr/bin/perl -w
# Example 3.5 - splice

@alpha = ('a' .. 'z');

#replace letters from four to eight with their uppercase equivalents.
splice @alpha, 4, 5, map(uc, @alpha[4 .. 8]);

$, = ' ';

push(@alpha, "\n");

print @alpha;
