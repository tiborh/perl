#!/usr/bin/perl -w

use strict;
use utf8;

my %romaji_hiragana = ();
my %平仮名漢字 = ();		# 平(even,flat,peace)仮(sham,temporary,interim,assumed(name),informal)名
my %漢字英語 = ();
my %漢字平仮名 = ();

my $fh;		# name of file handler, uninitialised scalar
my $fmr = "<"; 				# for reading
my $fn = "hashes_input.txt";		# name of the file

my @in_array = ();

open($fh,$fmr,$fn) or die "Unable to open $fn.\n $!";

while(<$fh>) {
    chomp;
    @in_array = split("\t",$_);
    $romaji_hiragana{$in_array[2]} = $in_array[1];
#got stuck here: the condition below is not true. one hiragana several kanji cannot be connected correctly to the other hashes in the structure built above.
    if (exists($平仮名漢字{$in_array[1]}) && ($平仮名漢字{$in_array[1]} !~ m/.*$in_array[0].*/)) {
	$平仮名漢字{$in_array[1]} .= ", " . $in_array[0];
    } else {
	$平仮名漢字{$in_array[1]} = $in_array[0];
    }
    $漢字英語{$in_array[0]} = $in_array[3];
    $漢字平仮名{$in_array[0]} = $in_array[1];
}

print("$平仮名漢字{$romaji_hiragana{'nanji'}} ($romaji_hiragana{'nanji'}): $漢字英語{$平仮名漢字{$romaji_hiragana{'nanji'}}}\n");
