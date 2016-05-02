#!/usr/bin/perl -w

use strict;

my %states;
my @linetmp = ();
my $infile = "states.csv";
my $strFound = "";

if (! open STATES,"<$infile") {
    die "Cannot open file $infile: $!";
}

while (<STATES>) {
    chomp;
    @linetmp = split(",",$_);
    #print(join(" ",reverse(@linetmp)),"\n");
    $states{$linetmp[1]} = $linetmp[0];
}

close STATES;

print "Give state abbreviations: \n";

while(<>) {
    chomp;
    $strFound = $states{uc($_)};
    if (!$strFound) {
	print("$_ is not a valid abbreviation\n");
	print("Valid keys: ",join(" ",sort(keys(%states))),"\n");
    } else {
	print $strFound,"\n";
    }
}
