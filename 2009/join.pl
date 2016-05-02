#!/usr/bin/perl -w

@alpha = ('a'..'z');

splice @alpha, @alpha, 0, "\n";

print @alpha;

print join ' ', @alpha;


