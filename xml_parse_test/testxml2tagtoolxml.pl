#!/usr/bin/env perl

use warnings;
use strict;
#use Cwd;
#use Time::Piece;
#use File::Basename;
#use Getopt::Std;
use v5.14;
use XML::Parser;
use utf8;
#depracated: use encoding 'utf8';
no warnings 'experimental::smartmatch'; #to avoid warning about experimental feature for "when"

#binmode STDOUT, ":utf8";
#binmode STDIN, ":utf8";

my $DEBUG = 0;

#check arguments:
die "arg 1: XML file to check,\narg 2: xsd to validate against" if ($#ARGV <= 0);
my $inXML = shift @ARGV;
my $inXSD = shift @ARGV;
die "File $inXML does not exist." unless (-e $inXML);
die "Empty file: $inXML" if (-s $inXML == 0);

#check and validate:
&xml_checker($inXML);
&xml_validator($inXML,$inXSD);
my $xml_tree = &get_xml_tree($inXML);

if ($DEBUG == 3) {
    use Data::Dumper;
    print Dumper($xml_tree);
}

&print_xmlhead(&get_date());

#parse
my %no_close = qw(confidentiality 1 language 1 colspec 1 company-symbol 1);
my $inside_category_filters = 0;
my $saved_line_number = 0;
my $inside_tp = 0;
my $chl_depth = 0;
my $line_number = 0;
my @out_lines = ();
my %category_filter_hash = ();
&parse_tree($xml_tree);
&despace_lines();
&repair_lines();

print STDERR "length of output array: ",scalar(@out_lines),"\n";
print foreach @out_lines;

&print_xmltail;

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

sub xml_validator() {
    use XML::SAX::ParserFactory;
    use XML::Validator::Schema;
    my $inXML = $_[0];
    my $xsd = $_[1];

    #
    # create a new validator object, using $xsd
    #
    my $validator = XML::Validator::Schema->new(file => $xsd);

    #
    # create a SAX parser and assign the validator as a Handler
    #
    my $parser = XML::SAX::ParserFactory->parser(Handler => $validator);

    #
    # validate foo.xml against $inXML
    #
    eval { $parser->parse_uri($inXML) };
    die "File failed validation: $@" if $@;
    print STDERR "'$inXML' has been validated successfully against '$xsd'\n";
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
    my %conversion_tags = qw(
ts:TestCases chl
ts:Story title
ts:JIRA resource-id
ts:TestCase chl
ts:Name title
ts:Steps step-list
ts:Step sl-item
ts:Description p:Description
ts:Actor p:Actor
ts:Precondition p:Precondition
ts:Action p:Action
ts:Result stepresult
);
    my %do_not_print_tags = qw(

);

    my %do_not_parse = qw(
titled-block 1
description 1
revision-history 1
);

    my %out_sgml_tags = (
	chl => ""
	);

    my $open_tag = "";
    my $tag_attribs = "";

    print STDERR "->xml_tree:\n\t$xml_tree\n" if ($DEBUG == 9);
    # the array has the tag name (as string), attribute list (as hash), and tag text (as string after the member hash reference
    if (ref($xml_tree) =~ /ARRAY/) {
	if ($DEBUG == 9) {
	    print STDERR "->array content:\n\t@$xml_tree";
	    my $array_length = @$xml_tree;
	    print STDERR "->Array length: $array_length\n";
	}
	# the doc pattern: ['doc', arrayref], other pattern: [hashref,'tagname',arrayref,tagtext or 0,"\n",etc, starting with another 'tagname' if there are more]
	foreach (0..$#$xml_tree) {
	    # the return statements below are rough quick fixes which will need to be replaced later because they skip any occurrence of these words not only in tag texts
	    return if (exists($do_not_parse{$$xml_tree[$_]}));
	    next if (exists($do_not_print_tags{$$xml_tree[$_]}));
	    my $pointer = $$xml_tree[$_];
	    if (ref($pointer) =~ /ARRAY/) {
		if (ref($pointer->[0]) =~ /HASH/) {
		    # removing the hashref from the arrayref
		    my $hash_ref = shift @$pointer;
#		    unless (defined($out_sgml_tags{$open_tag})) {
		    if (defined($tag_attribs)) {
			$tag_attribs = &process_attrib_hash($hash_ref,$open_tag) if ($tag_attribs eq "");
		    } else {
			$tag_attribs = "";
		    }
#		    }
		    
		    # category filters are given as comments inside <entry> tags
		    if ($tag_attribs) {
			$out_lines[$line_number] .= ($open_tag ? $tag_attribs : "<!--$tag_attribs-->");
			if (!$open_tag) {
			    #print STDERR "tag_attribs: $tag_attribs\n";
			    my @category_filters = split(/\s/,$tag_attribs);
			    $category_filter_hash{$_}++ foreach @category_filters;
			}
		    }

		    # checking if tag needs a closing tag
		    unless (defined($no_close{$open_tag})) {
			$out_lines[$line_number] .= ">" unless ($open_tag eq "");
		    	#print ">";
		    } else {	
			$out_lines[$line_number] .= ">\n";
		    	#print " />\n";
		    	$open_tag = "";
		    }
		    $tag_attribs = "";
		}
		&parse_tree($pointer);
	    } elsif ($pointer eq "\n") { # end of a tag information, if there are more tags on the same level the pattern repeats
		unless ($open_tag eq "") {
		    if ($open_tag =~ /chl\d/ and $inside_category_filters) {
			$out_lines[$line_number++] .= "-->\n";
			$inside_category_filters = 0;
		    }
		    if ($open_tag =~ /chl\d/ and !$inside_category_filters) {
			$out_lines[$saved_line_number] =~ s/<title>\s*/<title>/;
		    }
		    $open_tag =~ s/^p$/P/ if ($inside_category_filters);
		    $out_lines[$line_number] .= "</$open_tag>";
		    $inside_tp = 0 if $inside_tp;
		    print STDERR "<!--1-->" if ($DEBUG == 1);
		    $out_lines[$line_number++] .= "\n" unless $inside_category_filters;
		    if ($open_tag =~ /chl\d/) {
			my $collect_category_string = "";
			if (%category_filter_hash and !$inside_category_filters) {
			    $collect_category_string .= "<!-- |";
			    $collect_category_string .= " $_" foreach (sort keys %category_filter_hash);
			    $collect_category_string .= "-->";
			    %category_filter_hash = ();
			}
			$out_lines[$saved_line_number] =~ s/(<chl\d>)(<title>)/$1$collect_category_string$2/;
		    }
		    $chl_depth-- if ($open_tag =~ /chl\d/);
		    $open_tag = "";
		    print STDERR "\\n\n" if ($DEBUG == 9);
		}
	    } elsif ($pointer eq "0") { # there is no tag text, empty tag, or tag with no end-tag
		print STDERR "***No tag text***\n" if ($DEBUG == 9);
	    } elsif (ref($pointer) eq "") {
		my $is_tag_printed = 0;
		# if the next is an array ref, then this one is a tag name
		if (ref($$xml_tree[$_+1]) =~ /ARRAY/) {
		    unless ($open_tag eq "") {
			$out_lines[$line_number] .= "</$open_tag>";
			print STDERR "<!--2-->" if ($DEBUG == 1);
			$out_lines[$line_number++] .= "\n";
			$open_tag = "";
		    }
		    if ($pointer eq "selection-list" and !$inside_category_filters) {
			$out_lines[$line_number] .= "<!--";
			$inside_category_filters++;
		    }
		    unless ($pointer eq "tp") {
			$out_lines[$line_number] .= "\n" if $pointer eq "meta-data";
		    	$out_lines[$line_number] .= "<";
		    }
		    if ($pointer eq "chl") {
			$chl_depth++;
			$open_tag = $pointer . $chl_depth;
			$out_lines[$line_number] .= $open_tag;
			$saved_line_number = $line_number;
			$is_tag_printed = 1;
		    } elsif (exists($conversion_tags{$pointer}) and defined($conversion_tags{$pointer})) {
			$open_tag =  $conversion_tags{$pointer};
			$out_lines[$line_number] .= $open_tag;
			$is_tag_printed = 1;
		    } elsif ($pointer eq "tp") {
			$inside_tp = 1;
			$pointer = "";
		    } else {
			$open_tag = $pointer;
		    }
		    if (exists($out_sgml_tags{$open_tag}) and defined($out_sgml_tags{$open_tag})) {
			if ($out_sgml_tags{$open_tag} eq "") {
			    undef $tag_attribs;
			} else {
			    $tag_attribs = $out_sgml_tags{$open_tag};
			}
		    } 
		}
		print STDERR "->$pointer\n" if ($DEBUG == 9);
		unless ($is_tag_printed) {
		    $pointer =~ s/\n/ /gm;
		    if ($pointer =~ />>>(.+?);/) {
			my $symbol = $1;
			$pointer =~ s/>>>$symbol;/&$symbol;/g;
		    }
		    $pointer =~ s/^p$/P/ if ($inside_category_filters);
		    $out_lines[$line_number] .= $pointer;
		    $is_tag_printed = 0;
		}
	    } else {		# a safety measure for uncaught reference types
		print STDERR "Uncaught reference: ",ref($pointer),"\n";
	    }
	}
	unless ($open_tag eq "") { # close unclosed tags
	    $out_lines[$line_number] .= "</$open_tag>";
	    print STDERR "<!--3-->" if ($DEBUG == 1);
	    $out_lines[$line_number++] .= "\n";
	    $open_tag = "";
	}
    }
}

sub process_attrib_hash() {
    my $attrib_hash = shift;
    my $open_tag = shift;
    my $attrib_string = "";

    for ($open_tag) {
	when (/Description/) {
	    $attrib_string = ' annotation="Description"';
	}
	when (/Actor/) {
	    $attrib_string = ' annotation="Actor"';
	}
	when (/Precondition/) {
	    $attrib_string = ' annotation="Precondition"';
	}
	when (/Action/) {
	    $attrib_string = ' annotation="Action"';
	}
    }
    return $attrib_string;
}

sub despace_lines() {
    my $xml_tree = shift;
    foreach (@out_lines) {
	s/(\s)+/$1/g;
	s/\s</</g;
    }
}

sub repair_lines() {
    my $xml_tree = shift;
    foreach (@out_lines) {
	s/<stepresult>([\w\s\p{PosixPunct}\d]+)<\/stepresult>/<stepresult><p>$1<\/p><\/stepresult>/;
	#s/<p:(\w+)(\s*[\w"=]*)>(.+)<\/p:\1>/<p$2><emph>$1:<\/emph> $3<\/p>/;
	s/<p:(\w+)(\s*[\w"=]*)>(.+)<\/p:\1>/<p><emph>$1:<\/emph> $3<\/p>/;
    }
}

sub get_date() {
    my @date_array = localtime();
    if ($DEBUG > 1)
    {
	print STDERR "$_, " for (@date_array);
	print STDERR "\n";
    }

    return ($date_array[3],$date_array[4]+1,$date_array[5]+1900);
}

sub print_xmlhead() {
    print STDERR "head input: @_\n" if ($DEBUG > 1);
    my %mydate = ("year" => $_[2], "month" => $_[1], "day" => $_[0]);
    my $docnum = "1/152 41-APR 901 0509";
    my $docrev = "PA1";
    my $docname = "TEST SPECIFICATION";
    my $doctitle = "Manual Test Cases for LAT";
    my $draftname = "Tibor Harcsa";
    my $draftid = "etibhar";
    my $busunit = "BNET";

    print <<EOF;
<?xml version="1.0" encoding="UTF-8"?>
<!--Arbortext, Inc., 1988-2008, v.4002-->
<!DOCTYPE doc PUBLIC "-//ERICSSON//DTD XSEIF 1/FAD 110 05 R6//EN"
 "XSEIF_R6.dtd">
<doc version="XSEIF R6"
xmlns="urn:x-ericsson:r2:reg-doc:1551-fad.110.05:en:*">
<meta-data><?Pub Dtl?>
<confidentiality class="ericsson-internal"/>
<doc-name>$docname</doc-name>
<doc-id>
<doc-no type="registration">$docnum</doc-no><language code="en"/><rev>$docrev</rev>
<date><y>$mydate{"year"}</y><m>$mydate{"month"}</m><d>$mydate{"day"}</d></date>
</doc-id>
<company-id>
<business-unit>$busunit</business-unit>
<company-name></company-name>
<company-symbol logotype="ericsson"></company-symbol>
</company-id>
<title>$doctitle</title>
<drafted-by>
<person>
<name>$draftname</name><signature>$draftid</signature>
</person>
</drafted-by>
<approved-by approved="no">
<person>
<name></name><signature></signature>
</person>
</approved-by>
</meta-data>
<front></front>
<body>
EOF
}

sub print_xmltail() {
    print <<EOF;
</body>
</doc>
EOF
}
