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

my $chl_depth = 0;
my $inside_category_filters = 0;
my $inside_tp = 0;
$line_number = 0;
my $saved_line_number = 0;
my @out_lines = ();
my %category_filter_hash = ();
# my $chapter_category_collect = {
#     chl1 => {},
#     chl2 => {},
#     chl3 => {},
#     chl4 => {},
#     chl5 => {},
#     chl6 => {},
# };
&parse_tree($xml_tree);
#&draw_chapters(@out_lines);
print STDERR "length of output array: ",scalar(@out_lines),"\n";
print foreach @out_lines;

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
	next if /^\s*$/;
	if (/&(.+?);/) {
	    my $symbol = $1;
	    print STDERR "'$_'\n" if $DEBUG;
	    s/&$symbol;/>>>$symbol;/g;
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

);
    # taken out:
    # tp 1
# colspec 1

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
	);
    # taken out:
    # tp => "",
    # colspec => ""

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
		    # if ($open_tag =~ /chl\d/) {
		    # 	print STDERR "->open_tag: $open_tag, tag_attribs: '$tag_attribs'\n";
		    # 	print STDERR "->empty tag_attribs\n" unless ($tag_attribs);
		    # 	print STDERR ' role=" "' if ($tag_attribs eq "");
		    # }
		    
		    # category filters are given as comments inside <entry> tags
		    if ($tag_attribs) {
			$out_lines[$line_number] .= ($open_tag ? $tag_attribs : "<!--$tag_attribs-->");
			if (!$open_tag) {
			    #print STDERR "tag_attribs: $tag_attribs\n";
			    my @category_filters = split(/\s/,$tag_attribs);
			    $category_filter_hash{$_}++ foreach @category_filters;
			    #print STDERR "category_filters: @category_filters\n";
			    #print STDERR  "category hash:\n";
			    #print STDERR ("$_ => $category_filter_hash{$_}\n") foreach (sort keys %category_filter_hash);
			}
		    }


		    #print $tag_attribs if $open_tag;
		    # checking if tag needs a closing tag
		    unless (defined($no_close{$open_tag})) {
			$out_lines[$line_number] .= ">" unless ($open_tag eq "");
		    	#print ">";
		    } else {	
			$out_lines[$line_number] .= ">\n";
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
			$out_lines[$line_number++] .= "-->\n";
			$inside_category_filters = 0;
		    }
		    if ($open_tag =~ /chl\d/ and !$inside_category_filters) {
			$out_lines[$saved_line_number] =~ s/<title>\s*/<title>/;
			#print STDERR "saved line (nu $saved_line_number): $out_lines[$saved_line_number]";
			#print STDERR "chapter: $open_tag (current line number: $line_number)\n";
			#print STDERR "filter hash: ",%category_filter_hash,"\n";
		    }
		    $open_tag =~ s/^p$/P/ if ($inside_category_filters);
		    $out_lines[$line_number] .= "</$open_tag>";
		    $inside_tp = 0 if $inside_tp;
		    print STDERR "<!--1-->" if ($DEBUG == 1);
		    $out_lines[$line_number++] .= "\n" unless $inside_category_filters;
		    if ($open_tag =~ /chl\d/) {
			my $collect_category_string = "";
			if (%category_filter_hash and !$inside_category_filters) {
			    #print STDERR ("$_ => $category_filter_hash{$_}\n") foreach (sort keys %category_filter_hash);
			    $collect_category_string .= "<!-- |";
			    $collect_category_string .= " $_" foreach (sort keys %category_filter_hash);
			    $collect_category_string .= "-->";
			    #print STDERR "$collect_category_string\n";
			    %category_filter_hash = ();
			}
			$out_lines[$saved_line_number] =~ s/(<chl\d>)(<title>)/$1$collect_category_string$2/;
			# print STDERR "opening line: $out_lines[$saved_line_number]";
			# print STDERR "current line: $out_lines[$line_number-1]";
		    }
		    $chl_depth-- if ($open_tag =~ /chl\d/);
		    $open_tag = "";
		    print STDERR "\\n\n" if ($DEBUG == 9);
		}
	    } elsif ($pointer eq "0") { # there is no tag text, empty tag, or tag with no end-tag
		print STDERR "***No tag text***\n" if ($DEBUG == 9);
		#print "";
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
		    # $out_lines[$line_number] .= "<" unless ($pointer eq "tp");
		    unless ($pointer eq "tp") {
			#print STDERR "open_tag: $open_tag\n";
		    	#$out_lines[$line_number] .= "\n" if (scalar(@out_lines) > 0 && substr($out_lines[-1],-1) eq ">");
			$out_lines[$line_number] .= "\n" if $pointer eq "meta-data";
		    	$out_lines[$line_number] .= "<";
		    }
		    if ($pointer eq "chl") {
			$chl_depth++;
			$open_tag = $pointer . $chl_depth;
			$out_lines[$line_number] .= $open_tag;
			$saved_line_number = $line_number;
			$is_tag_printed = 1;
			# print STDERR "<<<chl>>>\n" if ($DEBUG == 9);
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
		print STDERR "->$pointer\n" if ($DEBUG == 9);
		unless ($is_tag_printed) {
		    $pointer =~ s/\n/ /gm;
		    if ($pointer =~ />>>(.+?);/) {
			my $symbol = $1;
			#print STDERR "'$_'\n";
			$pointer =~ s/>>>$symbol;/&$symbol;/g;
			#exists($code_conversions{$symbol}) ? $pointer =~ s/>>>$symbol;/&$symbol;/ : print STDERR "undefined: &$symbol;\n";
		    }
		    #print STDERR "->pointer is printed: >>>";
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
    unless ($open_tag) {
	if (exists($attrib_hash->{"role"}) and defined($attrib_hash->{"role"})) {
	    return $attrib_hash->{"role"} unless ($attrib_hash->{"role"} =~ /fetch_only/);
	}
    }
    return "" unless ($open_tag);
    foreach (keys %$attrib_hash) {
	my $the_attrib = $_;
	#print STDERR "->role: $_, open_tag: $open_tag" if (/role/);

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

sub draw_chapters() {
    print STDERR "The chapters:\n";
    my %chapter_hash = ();
    my $chapters = {};
    for (0..@_-1) {
	if ($_[$_] =~ /<chl\d/) {
	    $_[$_] =~ s/<title>\s*/<title>/;
	    $_[$_] =~ s/(<chl1.*?>).*(<title>).*(Category Filters).*(<\/title>)/$1$2$3$4/i;
	    if ($_[$_] =~ /<chl(\d).*<title>(.+)<\/title>/) {
		$chapters->{$_} = [$1,$2];
		my $key = $1." ".$2;
		$chapter_hash{$key} = $_;
		if ($_[$_] =~ /(?<=<!-- \| )(.*)(?=-->)/) {
		    push @{$chapters->{$_}},$1;
		    my @categ_array = split(/\s+/,$1) ;
		}
	    }
	}
    } 
    foreach (reverse sort {$a <=> $b} keys %$chapters) {
    	print STDERR "$_: ";
    	print STDERR "|$_|" foreach @{$chapters->{$_}};
	print STDERR "(",scalar(@{$chapters->{$_}}),")";
    	print STDERR "\n";
    }
    &tree_builder($chapters);
    #&bubble_up_categories($chapters);

    # foreach (reverse sort {$a <=> $b} keys %$chapters) {
    # 	print STDERR "$_: ";
    # 	print STDERR "|$_|" foreach @{$chapters->{$_}};
    # 	print STDERR "(",scalar(@{$chapters->{$_}}),")";
    # 	print STDERR "\n";
    # }

    sub tree_builder {
	use Data::Dumper;
	my $chapters = shift;
	my $chapter_tree;
	my @upper_stack;
# a closer examination of this stack handling will be needed to make sure that references are stacked and not lists flattened.
	push @upper_stack,[0,0]; 	# 0: level number of upper; 1: line number of upper;
	my @previous = (0,0);	# 0: level of previous; 1: line number of previous
	$$chapter_tree{0} = [$upper_stack[-1]->[0],$upper_stack[-1]->[1]];
	print STDERR Dumper($chapter_tree);
	foreach (sort {$a <=> $b} keys %$chapters) {
	    if ($$chapters{$_}[0] > $previous[0]) {
		push @upper_stack,[$previous[0],$previous[1]];
	    	$$chapter_tree{$_} = [$upper_stack[-1]->[0],$upper_stack[-1]->[1]];
	    	print STDERR "$_: first if (@upper_stack)\n";
	    }
	    # if ($$chapters{$_}[0] - 1 > $upper[0]) {
	    # 	$upper[0] = $$chapters{$_}[0];
	    # 	$upper[1] = $$chapter_tree{$_}[1];
	    # 	print STDERR "$_: second if (@upper)\n";
	    # }
	    if ($$chapters{$_}[0] == $previous[0]) {
	    	$$chapter_tree{$_} = [$upper_stack[-1]->[0],$upper_stack[-1]->[1]];
	    	print STDERR "$_: second if (@upper_stack)\n";
	    }
# This will handle correctly only single jumps. A while loop will be needed for larger jumps.
	    if ($$chapters{$_}[0] < $upper_stack[-1]->[0]) {
		pop @upper_stack;
	    	$$chapter_tree{$_} = [$upper_stack[-1]->[0],$upper_stack[-1]->[1]];
		#@upper = ($$chapters{$_}[0],$_);
	    	print STDERR "$_: second if (@upper_stack)\n";
	    }
	    @previous = ($$chapters{$_}[0],$_);
	}
	print STDERR "The tree:\n";
	print STDERR Dumper($chapter_tree);
    }

    sub bubble_up_categories {
	my $chapters = shift;
	my %collector_hash = ();

	print STDERR "Length of chapters: ",scalar(keys %$chapters),"\n";
	foreach (reverse sort {$a <=> $b} keys %$chapters) {
	    if (scalar(@{$chapters->{$_}}) >= 3) {
		my @category_array = split /\s/,$$chapters{$_}[2];
		$collector_hash{$_}++ foreach (@category_array);
		print STDERR "$_: collector_hash: ",sort(keys %collector_hash),"\n";
	    }
	    if (%collector_hash) {
		if ($$chapters{$_}[0] eq "chl1") {
#!!!!something is wrong here!!! (sort has been deleted)
		    $$chapters{$_}[2] = keys %collector_hash;
		    # print STDERR "$_: collector_hash: ",sort(keys %collector_hash),"\n";
		    %collector_hash = ();
		}
	    }
	}
    }
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
    print STDERR "$_ => $tag_hash{$_}\n" foreach (sort keys %tag_hash);
}

}
