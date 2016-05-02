#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

use Spreadsheet::Read;
my $workbook = ReadData ("sample.ods") or die "Cannot read file.";

say "number of workbook tables: ",scalar(@$workbook);

say "workbook is an array reference: ",$workbook;
say "The array is an array of hash references: ",@$workbook;
say "zeroth row is never to be used:";
#say %$_ foreach @$workbook;
say "workbook #$_ ",%{$workbook->[$_]} foreach (1..$#$workbook);
say "sheet data are stored with coordinate hashes:";
foreach my $sheet_number (1..$#$workbook) {
    say "\nSheet $sheet_number";
    foreach my $a_cell_key (sort keys %{$workbook->[$sheet_number]}) {
	say "$a_cell_key => ",$workbook->[$sheet_number]->{$a_cell_key};
    }
}
