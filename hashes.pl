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
    if (/^#/ || /^\s*$/) {next;}
    chomp;
    @in_array = split("\t",$_);
    $romaji_hiragana{$in_array[2]} = $in_array[1];
    if (exists $平仮名漢字{$in_array[1]}) {
	die "already stored: $in_array[1] (conflicting: $平仮名漢字{$in_array[1]} vs $in_array[0])\n";
    } else {
	$平仮名漢字{$in_array[1]} = $in_array[0];
    }
    if (exists $漢字平仮名{$in_array[0]}) {
	die "already stored: $in_array[0] (conflicting: $漢字平仮名{$in_array[0]} vs $in_array[1])\n";
    } else {
	$漢字英語{$in_array[0]} = $in_array[3];
    }
}

%漢字平仮名 = reverse %平仮名漢字;

foreach my $key (sort keys %romaji_hiragana) {
    printf("%s \t (%s) \t %s\n",$平仮名漢字{$romaji_hiragana{$key}},$romaji_hiragana{$key},$漢字英語{$平仮名漢字{$romaji_hiragana{$key}}});
}
