#!/usr/bin/perl -w

use strict;
use Cwd;
use Time::Piece;
use File::Basename;
use Getopt::Std;
use v5.14;
use XML::Parser;

my $DEBUG = 0;

my %no_close = qw(confidentiality 1 language 1 colspec 1);

die "XML file to check is required as an argument." if ($#ARGV == -1);
my $inXML = shift @ARGV;
die "File $inXML does not exist." unless (-e $inXML);
die "Empty file: $inXML" if (-s $inXML == 0);

&xml_checker($inXML);
# &xml_dumper($inXML);
my $xml_tree = &get_xml_tree($inXML);
&print_xmlhead;

my %tag_hash = ();
&fill_tag_hash();
&parse_tree($xml_tree);

sub xml_checker() {
    my $inXML = $_[0];

# initialize parser object and parse the string
    my $parser = XML::Parser->new( ErrorContext => 2 );
    eval { $parser->parsefile( $inXML ); };
    
# report any error that stopped parsing, or announce success
    if( $@ ) {
	$@ =~ s/at \/.*?$//s;               # remove module line number
	print STDERR "\nERROR in '$inXML':\n$@\n";
	return 0;
    } else {
	print STDERR "'$inXML' is well-formed\n";
	return 1;
    }
}

sub get_xml_tree() {
    my $inXML = $_[0];

# initialize parser and read the file
    my $parser = new XML::Parser( Style => 'Tree' );
    my $tree = $parser->parsefile( $inXML );
 
    return $tree;
}

sub parse_tree() {
    my $xml_tree = shift;
    print "->xml_tree:\n\t$xml_tree\n" if ($DEBUG);
    # the array has the tag name (as string), attribute list (as hash), and tag text (as string after the member hash reference
    if (ref($xml_tree) =~ /ARRAY/) {
	if ($DEBUG) {
	    print "->array content:\n\t@$xml_tree";
	    my $array_length = @$xml_tree;
	    print "->Array length: $array_length\n";
	}
	my $open_tag = "";
	# the doc pattern: ['doc', arrayref], other pattern: [hashref,'tagname',arrayref,tagtext or 0,"\n",etc, starting with another 'tagname' if there are more]
	foreach (0..$#$xml_tree) {
	    my $pointer = $$xml_tree[$_];
	    if (ref($pointer) =~ /ARRAY/) {
		if (ref($pointer->[0]) =~ /HASH/) {
		    # removing the hashref from the arrayref
		    my $hash_ref = shift @$pointer;
		    print &process_attrib_hash($hash_ref);
		    # checking if tag needs a closing tag
		    unless (defined($no_close{$open_tag})) {
			print ">";
		    } else {	
			print "/>";
			$open_tag = "";
		    }
		}
		&parse_tree($pointer);
	    } elsif ($pointer eq "\n") { # end of a tag information, if there are more tags on the same level the pattern repeats
		print "</$open_tag>\n" unless ($open_tag eq "");
		$open_tag = "";
		print "\\n\n" if ($DEBUG);
	    } elsif ($pointer eq "0") { # there is no tag text, empty tag, or tag with no end-tag
		print "***No tag text***\n" if ($DEBUG);
		print "";
	    } elsif (ref($pointer) eq "") {
		# if the next is an array ref, then this one is a tag name
		if (ref($$xml_tree[$_+1]) =~ /ARRAY/) {
		    unless ($open_tag eq "") {
			print "</$open_tag>";
			$open_tag = "";
		    }
		    print "<";
		    $open_tag = $pointer;
		    #$tag_hash{$open_tag}++;
		}
		print "$pointer";
	    } else {		# a safety measure for uncaught reference types
		print ref($pointer),"\n";
	    }
	}
	unless ($open_tag eq "") { # close unclosed tags
	    print "</$open_tag>\n";
	    $open_tag = "";
	}
    }
}

sub process_attrib_hash() {
    my $attrib_hash = shift;
    my $attrib_string = "";
    foreach (keys %$attrib_hash) {
	$attrib_string .= " $_=";
	$attrib_string .= "\"$attrib_hash->{$_}\"";
    }
    return $attrib_string;
}

sub print_xmlhead() {
    print <<EOF;
<?xml version="1.0" encoding="UTF-8"?>
<!--Arbortext, Inc., 1988-2008, v.4002-->
<!DOCTYPE doc PUBLIC "-//ERICSSON//DTD XSEIF 1/FAD 110 05 R6//EN" "XSEIF_R6.dtd">
EOF
}

sub fill_tag_hash() {
my @sdi_tags = qw(approved-by
body
business-unit
caption
checked-by
chl1
chl2
chl3
chl4
colspec
company
company-id
company-name
company-symbol
confidentiality
copyright
d
date
department
disclaimer
doc-id
doc-name
doc-no
drafted-by
entry
factual-supervisor
front
language
location
m
meta-data
name
owner
p
part-of
person
rev
row
seif
signature
table
tbody
tgroup
title
title-page
tm-item
trademark
trademark-list
user-info
y
approved-by
body
business-unit
caption
checked-by
chl1
chl2
colspec
company
company-id
company-name
company-symbol
confidentiality
copyright
d
date
department
disclaimer
doc-id
doc-name
doc-no
drafted-by
entry
factual-supervisor
front
language
location
m
meta-data
name
owner
p
part-of
person
rev
row
seif
signature
table
tbody
tgroup
title
title-page
tm-item
trademark
trademark-list
user-info
y
);
my @xsdi_tags = qw(
approved-by
body
business-unit
caption
checked-by
chl
colspec
company
company-id
company-name
company-symbol
confidentiality
copyright
d
date
def-list
department
description
disclaimer
doc
doc-id
doc-name
doc-no
dp
drafted-by
entry
factual-supervisor
front
language
location
m
meta-data
name
owner
p
part-of
person
rev
rev-info
revision-history
row
signature
table
tbody
tgroup
title
title-page
titled-block
tm-item
tp
trademark
trademark-list
user-info
y
);
$tag_hash{$_} = "s" foreach (@sdi_tags);
$tag_hash{$_} .= "x" foreach (@xsdi_tags);

if ($DEBUG) {
    print "$_ => $tag_hash{$_}\n" foreach (sort keys %tag_hash);
}

}
