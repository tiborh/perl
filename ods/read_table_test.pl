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


if (scalar(@ARGV) < 1) {
    say "Needed first argument as filename (.ods).";
    exit(1);
}

say "The argument: ",$ARGV[0];

my $book = ReadData($ARGV[0]);
say "Size of the book: ",scalar(@$book);
# foreach my $tab (@$book) {
#     say $tab;
# }

say "the metadata of the zeroeth tab:";
foreach (sort keys %{$book->[0]}) {
    print "\t$_: ";
    my $value = $book->[0]->{$_};
    print defined($value) ? $value : "undefined";
    say "";
}

say "the content of the zeroeth tab:";
foreach (sort { $book->[0]->{"sheet"}->{$a} <=> $book->[0]->{"sheet"}->{$b} } keys $book->[0]->{"sheet"}) {
    my $value = $book->[0]->{"sheet"}->{$_};
    say "\ttab $value has label $_";
}

say "first tab:";
&book_examine($book,1);
#say $_ foreach @{$book->[1]->{"cell"}};
#say "@$_" foreach @{$book->[1]->{"cell"}};
&print_cells($book,1);
#say "\t$_: ",$book->[1]->{$_} foreach (sort keys %{$book->[1]});

sub book_examine {
    my $book = shift;
    my $sheet = shift;

    say "\tlabel: ",$book->[$sheet]->{"label"};
    say "\tmaxrow: ",$book->[$sheet]->{"maxrow"};
    say "\tmaxcol: ",$book->[$sheet]->{"maxcol"};
    say "\tattr: ",@{$book->[$sheet]->{"attr"}};
    say "\tmerged: ",@{$book->[$sheet]->{"merged"}};
    say "the sheet has ",$#{$book->[$sheet]->{"cell"}}," columns.";
}

sub print_cells {
    my $book = shift;
    my $sheet = shift;

    for my $row (1..$book->[$sheet]->{"maxrow"}) {
	for my $col (1..$book->[$sheet]->{"maxcol"}) {
	    my $value = $book->[$sheet]->{"cell"}->[$col]->[$row];
	    print defined($value) ? $value : "undef";
	    print "\t";
	}
	say "";
    }
}
