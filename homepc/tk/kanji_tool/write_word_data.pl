#!/usr/bin/perl -w
use XML::Writer;
use strict;

use utf8;
use encoding 'utf8';
#binmode STDIN, 'encoding(UTF-8)';
#binmode STDOUT, 'encoding(UTF-8)';

use LangDat;

my %word_data = %LangDat::word_data;
my @word_data_types = @LangDat::word_data_types; #(qw(平仮名 英 例))
my @word_data_example_types = @LangDat::word_data_example_types; #(qw(日 平 英))

my $fh;
my $fn = "word_data.xml";
my $fm = ">:encoding(UTF-8)";
open $fh,$fm,$fn or die "Cannot open $fn: $!";
my $writer = XML::Writer->new(DATA_MODE => 'true', DATA_INDENT => 2, OUTPUT => $fh);

$writer->xmlDecl('UTF-8');

$writer->startTag("言葉");

foreach my $word (keys %word_data) {
    $writer->startTag($word);
    foreach my $info_type (@word_data_types) { 	# same as (keys %{$word_data{$word}})
	$writer->startTag($info_type);
	foreach my $info (sort keys %{$word_data{$word}{$info_type}}) {
	    $writer->startTag("numlist-item",'number' => $info);
	    if ($info_type eq "例") {
		foreach (@word_data_example_types) {	# same as (keys %{$word_data{$word}{$info_type}{$info}})
		    $writer->dataElement($_,$word_data{$word}{$info_type}{$info}{$_});
		}
	    } else {
		foreach (@{$word_data{$word}{$info_type}{$info}}) {
		    $writer->dataElement("data_item",$_);
		}
	    }
	    $writer->endTag("numlist-item");
	}
	$writer->endTag($info_type);
    }
    $writer->endTag($word);
}

$writer->endTag("言葉");

#$writer->startTag();
#$writer->characters();
#$writer->endTag();
#$writer->dataElement($words,"");

$writer->end();
close($fh);
