#!/usr/bin/perl -w

#this script attempts to break down input lines into <space> separated words

use strict;

my %words; #how many times each word appears in the input
my %frequency; #words in frequency groups
my @inline; #unparsed input line
my $word=""; #for single words

#input
print("Give me some strings (<space> separated):\n");

#if word already in hash, increment
#if word not yet in hash, store it there with value 1

while (<>) {
    chomp;
    @inline=split(" ",$_);
    foreach $word (@inline) {
	if (exists $words{lc($word)}) {
	    $words{lc($word)}++;
	} else {
	    $words{lc($word)}=1;
	}
    }
}

#list the contents of the hash, arranged according to keys/words

print("alphabetical order: \n");

foreach(sort(keys(%words))) {
    print("$_:\t",length($_)<7?"\t":"",$words{$_},"\n");
}

#create frequency hash:
#if the number is already there, append the word to that number
#if the number does not exist yet, add it to the hash, with the word as the value

foreach(keys(%words)) {
    if (exists $frequency{$words{$_}}) {
	$frequency{$words{$_}}.=(" ".$_);
    } else {
	$frequency{$words{$_}}=$_;
    }
}

#print out words in frequency order

print("frequency order: \n");

foreach(sort{$b <=> $a}(keys(%frequency))) {
    print("$_:\t",$frequency{$_},"\n");
}
