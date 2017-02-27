#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
# use diagnostics;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

my $subseqs = &subsequences($ARGV[0]);
if ($subseqs) {
    say "subsequences:";
    say $subseqs;
} else {
    say "no output";
}

sub subsequences() {
    my $word = shift // croak "no valid input for subsequences()";
    return join(',',reverse(split(/,/,&subsequencesAfter("", $word))));
}

sub subsequencesAfter() {
    my $partialSubsequence = shift // croak "no valid first arg in subsequencesAfter";
    my $word = shift // croak "no valid second arg in subsequencesAfter";
    if ($word eq "") {
        # base case
        return $partialSubsequence;
    } else {
        # recursive step
        return &subsequencesAfter($partialSubsequence, substr($word,1))
	    . ","
	    . &subsequencesAfter($partialSubsequence . substr($word,0,1), substr($word,1));
    }
}
