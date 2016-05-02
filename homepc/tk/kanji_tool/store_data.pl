#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
#use strict;
use Carp;
use utf8;
use encoding 'utf8';
binmode STDOUT, ":utf8";
use autodie;
#use Modern::Perl;
#use Test::More;

use LangDat;
use Storable;

my $fn_kanji = "kanji_data.txt";
store(\%LangDat::kanji_data,$fn_kanji) or die "Storage to $fn_kanji has failed, $!";

my %a = %{retrieve($fn_kanji)};
print "Kanji after the retrieval:\n";
&printIt("",\%a);

my $fn_words = "word_data.txt";
store(\%LangDat::word_data,$fn_words) or die "Storage to $fn_words has failed, $!";
my %b = %{retrieve($fn_words)};
print "Words after the retrieval:\n";
&printIt("",\%b);


sub printIt () {
    my $prefix = shift;
    my $in_ref = shift;
    die "Not a reference",caller() unless ref($in_ref);
    if (ref($in_ref) eq "HASH") {
	$prefix .= "\t";
	foreach my $key (sort keys %$in_ref) {
	    print "$prefix$key =>\n";
	    if (ref($$in_ref{$key})) {
		&printIt($prefix,$$in_ref{$key});
	    }
	}
    } elsif (ref($in_ref) eq "ARRAY") {
	print "$prefix\t$_\n" foreach (@$in_ref);
    }
}
