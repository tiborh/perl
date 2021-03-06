#!/usr/bin/perl -w

use strict;
#use Cwd;
#use Time::Piece;
#use File::Basename;
#use Getopt::Std;
use v5.14;
use XML::Parser;
use utf8;
use encoding 'utf8';

#binmode STDOUT, ":utf8";
#binmode STDIN, ":utf8";

my $DEBUG = 0;

die "XML file to check is required as an argument." if ($#ARGV == -1);
my $inXML = shift @ARGV;
die "File $inXML does not exist." unless (-e $inXML);
die "Empty file: $inXML" if (-s $inXML == 0);

my %no_close = qw(confidentiality 1 language 1 colspec 1 company-symbol 1);
my %code_conversions = qw(
copy 1
);
my $line_number = 0;

my $tmp_fn = &pre_process($inXML);
&xml_checker($tmp_fn);
# &xml_dumper($tmp_fn);
my $xml_tree = &get_xml_tree($tmp_fn);
unlink $tmp_fn;

#&print_xmlhead;
&print_sgmlhead;

my %tag_hash = ();
&fill_tag_hash();
{
    my $chl_depth = 0;
    my $inside_category_filters = 0;
    my $inside_tp = 0;
    my $line_number = 0;
    my @out_lines = ();
    &parse_tree($xml_tree);
}

sub pre_process() {
    my $in_fn = shift;
    my $in_fh;
    my $in_fm = "<";
    my $out_fn = "tmp" . make_time_stamp();
    my $out_fh;
    my $out_fm = ">";

    open($in_fh,$in_fm,$in_fn) or die "Cannot open $in_fn for reading, $!";
    open($out_fh,$out_fm,$out_fn) or die "Cannot open $out_fn for writing, $!";

    while (<$in_fh>) {
	if (/&(.+?);/) {
	    my $symbol = $1;
	    print "'$_'\n" if $DEBUG;
	    s/&$symbol;/>>>$symbol;/
	    #exists($code_conversions{$symbol}) ? s/&$symbol;/>>>$symbol;/ : print STDERR "undefined: &$symbol;\n";
	}
	print $out_fh $_;
    }
    close $in_fh;
    close $out_fh;

    return $out_fn;
}

sub make_time_stamp {

    my @art = localtime(time);
    my $timestamp = sprintf("%4d%02d%02d_%02d%02d%02d",$art[5]+1900,++$art[4],$art[3],$art[2],$art[1],$art[0]);

    return $timestamp;
}

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
    my %conversion_tags = qw(
doc seif
selection-item SELECTION-ITEM
selection-list SELECTION-LIST
);
    my %do_not_print_tags = qw(
colspec 1
);
    # taken out:
    # tp 1

    my %do_not_parse = qw(
titled-block 1
description 1
revision-history 1
);
#taken out:
#selection-list 1

    my %out_sgml_tags = (
	seif => ' toc-level="toc2" table-caption="tc-no"',
	"approved-by" => "",
	title => "",
	entry => "",
	colspec => ""
	);
    # taken out:
    # tp => "",

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
		    #if ($open_tag =~ /chl\d/) {
			#print STDERR "->open_tag: $open_tag, tag_attribs: '$tag_attribs'\n";
			#print STDERR "->empty tag_attribs\n" unless ($tag_attribs);
			#print STDERR ' role=" "' if ($tag_attribs eq "");
		    #}
		    
		    # category filters are given as comments inside <entry> tags
		    print ($open_tag ? $tag_attribs : "<!--$tag_attribs-->") if $tag_attribs;

		    #print $tag_attribs if $open_tag;
		    # checking if tag needs a closing tag
		    unless (defined($no_close{$open_tag})) {
			print ">" unless ($open_tag eq "");
		    	#print ">";
		    } else {	
			print ">\n";
		    	#print " />\n";
		    	$open_tag = "";
		    }
		    #print "<!--$tag_attribs-->" if ($tag_attribs =~ /role=/ and $open_tag eq "td");
		    $tag_attribs = "";
		}
		&parse_tree($pointer);
	    } elsif ($pointer eq "\n") { # end of a tag information, if there are more tags on the same level the pattern repeats
		unless ($open_tag eq "") {
		    if ($open_tag =~ /chl\d/ and $inside_category_filters) {
			print "-->\n";
			$inside_category_filters = 0;
		    }
		    $open_tag =~ s/^p$/P/ if ($inside_category_filters);
		    print "</$open_tag>";
		    $inside_tp = 0 if $inside_tp;
		    print "<!--1-->" if ($DEBUG == 1);
		    print "\n" unless $inside_category_filters;
		    $chl_depth-- if ($open_tag =~ /chl\d/);
		    $open_tag = "";
		    print "\\n\n" if ($DEBUG == 9);
		}
	    } elsif ($pointer eq "0") { # there is no tag text, empty tag, or tag with no end-tag
		print "***No tag text***\n" if ($DEBUG == 9);
		print "";
	    } elsif (ref($pointer) eq "") {
		my $is_tag_printed = 0;
		# if the next is an array ref, then this one is a tag name
		if (ref($$xml_tree[$_+1]) =~ /ARRAY/) {
		    unless ($open_tag eq "") {
			print "</$open_tag>";
			print "<!--2-->" if ($DEBUG == 1);
			print "\n";
			$open_tag = "";
		    }
		    if ($pointer eq "selection-list" and !$inside_category_filters) {
			print "<!--";
			$inside_category_filters++;
		    }
		    #unless ($pointer eq "td") {
		    print "<" unless $pointer eq "tp";
		    if ($pointer eq "chl") {
			$chl_depth++;
			$open_tag = $pointer . $chl_depth;
			print $open_tag;
			$is_tag_printed = 1;
			print "<<<chl>>>\n" if ($DEBUG == 9);
		    } elsif (exists($conversion_tags{$pointer}) and defined($conversion_tags{$pointer})) {
			$open_tag =  $conversion_tags{$pointer};
			print $open_tag;
			$is_tag_printed = 1;
		    } elsif ($pointer eq "tp") {
			$inside_tp = 1;
			$pointer = "";
		    } else {
			$open_tag = $pointer;
		    }
		    #print "->exists" if (exists($out_sgml_tags{$open_tag}));
		    #print "->defined" if (defined($out_sgml_tags{$open_tag}));
		    #print "->empty attrib" if $out_sgml_tags{$open_tag} eq "";
		    if (exists($out_sgml_tags{$open_tag}) and defined($out_sgml_tags{$open_tag})) {
			if ($out_sgml_tags{$open_tag} eq "") {
			    undef $tag_attribs;
			} else {
			    $tag_attribs = $out_sgml_tags{$open_tag};
			}
		    } 
		}
		print "->$pointer\n" if ($DEBUG == 9);
		unless ($is_tag_printed) {
		    $pointer =~ s/\n/ /gm;
		    if ($pointer =~ />>>(.+?);/) {
			my $symbol = $1;
			#print "'$_'\n";
			$pointer =~ s/>>>$symbol;/&$symbol;/;
			#exists($code_conversions{$symbol}) ? $pointer =~ s/>>>$symbol;/&$symbol;/ : print STDERR "undefined: &$symbol;\n";
		    }
		    #print "->pointer is printed: >>>";
		    $pointer =~ s/^p$/P/ if ($inside_category_filters);
		    print $pointer;
		    $is_tag_printed = 0;
		}
	    } else {		# a safety measure for uncaught reference types
		print ref($pointer),"\n";
	    }
	}
	unless ($open_tag eq "") { # close unclosed tags
	    print "</$open_tag>";
	    print "<!--3-->" if ($DEBUG == 1);
	    print "\n";
	    $open_tag = "";
	}
    }
}

sub process_attrib_hash() {
    my $attrib_hash = shift;
    my $open_tag = shift;
    my $attrib_string = "";
    unless ($open_tag) {
	if (exists($attrib_hash->{"role"}) and defined($attrib_hash->{"role"})) {
	    return $attrib_hash->{"role"} unless ($attrib_hash->{"role"} =~ /fetch_only/);
	}
    }
    return "" unless ($open_tag);
    foreach (keys %$attrib_hash) {
	my $the_attrib = $_;
	#print "->role: $_, open_tag: $open_tag" if (/role/);

	# for attribs handled globally
	given ($_) {
	    when (/role/) {
		$attrib_hash->{$_} =~ s/fetch_only/FETCH_ONLY/;
		$attrib_hash->{$_} =~ s/image_only/IMAGE_ONLY/;
	    }
	}
	# for attribs of a particular tag
	given ($open_tag) {
	    when (/colspec/) {
		next unless ($the_attrib =~ /colwidth/);
	    }
	    when (/confidentiality/) {
		$attrib_hash->{class} =~ s/ericsson-(.*)/$1/;
	    }
	    when (/doc-name/) {
		return ' id="SDIeditor"';
	    }
	    when (/user-info/) {
		return ' id=' . $attrib_hash->{$the_attrib};
	    }
	    when (/entry/) {
		return '';
	    }
	    when (/title-page/) {
		return '';
	    }
	    when (/table/) {
		return ' l-r="half-indent"';
	    }
	    when (/tgroup/) {
		next unless ($the_attrib =~ /cols/);
	    }
	    when (/selection-item/i) {
		#print STDERR "in selection-item ($the_attrib)\n";
		$the_attrib =~ s/role/ROLE/;
		#print STDERR "in selection-item ($the_attrib)\n";
	    }
	}
	$attrib_string .= " $the_attrib=";
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

sub print_sgmlhead() {
    print <<EOF;
<!DOCTYPE SEIF PUBLIC "-//ERICSSON//DTD SEIF 1/FAD 110 02 R1//EN" [
<!--Document generated by $0-->
]>
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

if ($DEBUG == 9) {
    print "$_ => $tag_hash{$_}\n" foreach (sort keys %tag_hash);
}

}
