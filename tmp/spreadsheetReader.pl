#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

use spreadsheetReader;
use trCommon;

my $FUNCDES = "designation";
my $PRODNUM = "number";
my $R_STATE = "rstate";

if (scalar(@ARGV) < 1) {
    say "Needed first argument as filename (.ods).";
    say "Three columns are expected for each release track:\n\t$FUNCDES\n\t$PRODNUM\n\t$R_STATE";
    croak "No file to work with.";
}

my $BOOKFILENAME = $ARGV[0];
my $DEBUG = $ARGV[1] || 0;

my $dataStructure = &spreadsheetReader::getStructure($BOOKFILENAME);

croak "Test failed." unless $dataStructure;
&spreadsheetReader::printDataStructures($dataStructure) if $DEBUG;
say "Test passed.";
