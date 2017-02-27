#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#use diagnostics;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

my $partialSubsequence = "";
foreach my $input (@ARGV) {
    my $subseqs = &subsequencesLouis($input);
    say "subsequences:";
    say "for '$input': $subseqs";
}

sub subsequencesLouis() {
    my $word = shift // croak "invalid input for subsequencesLouis()";
    if ($word eq "") {
        # base case
        return $partialSubsequence;
    } else {
        # recursive step
        my $withoutFirstLetter = &subsequencesLouis(substr($word,1));
        $partialSubsequence .= substr($word,0,1);
        my $withFirstLetter = &subsequencesLouis(substr($word,1));
        return $withoutFirstLetter . "," . $withFirstLetter;
    }
}

