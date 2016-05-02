#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;

binmode(STDOUT, ":utf8");

use Spreadsheet::Read;


if (scalar(@ARGV) < 1) {
    say "Needed first argument as filename (.ods).";
    exit(1);
}

#say "The argument: ",$ARGV[0];

my $book = ReadData($ARGV[0]);

my $nu_of_sheets = $book->[0]->{"sheets"};
#say "Number of sheets: ",$nu_of_sheets;

say "= Past Document Library Releases =";

for (my $i = 1; $i <= $nu_of_sheets; ++$i) {
    my $storetype;
    my $sheetname = $book->[$i]->{"label"};
    say "";
    say "== ",$sheetname," ==";
    if ($sheetname =~ /CPI/i) {
	$storetype =  "cpi";
    } elsif ($sheetname =~ /CAL/i) {
	$storetype = "cal";
    } else {
	die("unrecognised store name in tab txt");
    }
    &print_html_table($book,$i,0,$storetype);
}

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

sub print_html_table {
    my $book = shift;
    my $sheet = shift;
    my $tab_shift = shift || 0;
    my $storetype = shift || "cal";
    my $tabbing = "\t";
    my $pretab = $tabbing x $tab_shift;

    say "$pretab<table class='wikitable'>";
    for my $row (1..$book->[$sheet]->{"maxrow"}) {
	say "$pretab$tabbing<tr>";
	for my $col (1..$book->[$sheet]->{"maxcol"}) {
	    my $value = $book->[$sheet]->{"cell"}->[$col]->[$row];
	    print "$pretab$tabbing$tabbing";
	    print $row != 1 ? "<td>" : "<th>";
	    if (defined($value)) {
		$value = &parse_lib_string($value,$storetype) if ($value =~ /^EN\/LZN/i);
		print  $value;
	    } else {
		print "undef";
	    }
	    say $row != 1 ? "</td>" : "</th>";
	    #print "\t";
	}
	say "\t</tr>";
    }
    say "$pretab</table>";
}

sub parse_lib_string {
    my $value = shift;
    my $calcpi = shift || "cal";

    my %linkpre = ( "cal" => "http://calstore.internal.ericsson.com/alexserv?li=",
		    "cpi" => "http://cpistore.internal.ericsson.com/alexserv?li="
    );

    my $lnum;
    my $rst;
    my $llink = $linkpre{$calcpi};

    #say "link is needed";
    $value =~ /([PR]\d\w)/i;
    $rst = $1;
    #say "R-State: $rst";
    $value =~ /(^EN\/LZN[ \/0-9]+) /i;
    $lnum = $1;
    $lnum =~ s/ //g;
    #say "number: |$lnum|";
    $llink .= "$lnum$rst";
    #say $llink;
    $value = "[$llink $value]";

    return $value;
}
