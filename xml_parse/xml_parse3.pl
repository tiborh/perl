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
&parse_tree($xml_tree);
foreach (sort keys %tag_hash) {
    print "$_", ($DEBUG) ? " => $tag_hash{$_}\n" : "\n";
}
print scalar(keys %tag_hash),"\n";


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
    if (ref($xml_tree) =~ /ARRAY/) {
	if ($DEBUG) {
	    print "->array content:\n\t@$xml_tree";
	    my $array_length = @$xml_tree;
	    print "->Array length: $array_length\n";
	}
	my $open_tag = "";
	foreach (0..$#$xml_tree) {
	    my $pointer = $$xml_tree[$_];
	    if (ref($pointer) =~ /ARRAY/) {
		if (ref($pointer->[0]) =~ /HASH/) {
		    my $hash_ref = shift @$pointer;
		    print &process_attrib_hash($hash_ref);
		    unless (defined($no_close{$open_tag})) {
			print ">";
		    } else {
			print "/>";
			$open_tag = "";
		    }
		}
		&parse_tree($pointer);
#	    } elsif (ref($pointer) =~ /HASH/) {
#		print &process_attrib_hash($pointer),">";
	    } elsif ($pointer eq "\n") {
		print "</$open_tag>\n" unless ($open_tag eq "");
		$open_tag = "";
		print "\\n\n" if ($DEBUG);
	    } elsif ($pointer eq "0") {
		print "***No tag text***\n" if ($DEBUG);
		print "";
	    } elsif (ref($pointer) eq "") {
		if (ref($$xml_tree[$_+1]) =~ /ARRAY/) {
		    unless ($open_tag eq "") {
			print "</$open_tag>";
			$open_tag = "";
		    }
		    print "<";
		    $open_tag = $pointer;
		    $tag_hash{$open_tag}++;
		}
		print "$pointer";
	    } else {
		print ref($pointer),"\n";
	    }
	}
	unless ($open_tag eq "") {
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
