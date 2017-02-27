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

my $recurs_depth = 0;

my $subseqs = &subsequences($ARGV[0]);
if (defined $subseqs) {
    say "subsequences:";
    say $subseqs;
    say "depth of recursion: $recurs_depth";
} else {
    say "no output";
}

sub subsequences() {
    ++$recurs_depth;
    my $word = shift // croak "invalid input for subsequences()";
    if ($word eq "") {
	say "empty string branch";
	return ""; # base case
    } else {
	say "the other branch: subsequences('$word')";
	my $firstLetter = substr($word,0,1);
	my $restOfWord = substr($word,1);
	my $subsequencesOfRest = &subsequences($restOfWord);
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

