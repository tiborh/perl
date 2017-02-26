#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
use diagnostics;
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
    my $word = shift // croak "null input for subsequences()";
    if ($word eq "") {
	say "empty string branch";
	return ""; # base case
    } else {
	say "the other branch: subsequences('$word')";
	my $firstLetter = substr($word,0,1);
	#say "first letter: '$firstLetter'";
	my $restOfWord = substr($word,1);
	#say "rest of the word: '$restOfWord'";
	my $subsequencesOfRest = &subsequences($restOfWord);
	#say "subseqs of rest: '$subsequencesOfRest'";
	my $result = "," . $firstLetter if $firstLetter;
	foreach my $subsequence  (split(/,/,$subsequencesOfRest)) {
	    #say "in foreach, subsequence == '$subsequence'";
	    $result .= "," . $subsequence;
	    $result .= "," . $firstLetter . $subsequence;
	}

	#say "result after foreach(): '$result'";
	$result = substr($result,1) if $result; # remove extra leading comma
	$result .= ',';
	return $result;
    }
}

