#!/usr/bin/perl -w

use strict;
use Cwd;
use Time::Piece;
use File::Basename;
use Getopt::Std;
use v5.14;
use XML::Parser;

my $DEBUG = 0;

die "XML file to check is required as an argument." if ($#ARGV == -1);
my $inXML = shift @ARGV;
die "File $inXML does not exist." unless (-e $inXML);
die "Empty file: $inXML" if (-s $inXML == 0);

&xml_checker($inXML);
# &xml_dumper($inXML);
my $xml_tree = &get_xml_tree($inXML);
my $prefix;
&parse_tree($xml_tree);

sub xml_checker($) {
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

sub get_xml_tree($) {
    my $inXML = $_[0];

# initialize parser and read the file
    my $parser = new XML::Parser( Style => 'Tree' );
    my $tree = $parser->parsefile( $inXML );
 
    return $tree;
}

# The following is more like a dumper
sub parse_tree($) {
    my $xml_tree = shift;
    my $separator = " ";
    $prefix .= $separator;
    if (ref $xml_tree) {
	given (ref $xml_tree) {
	    when (/ARRAY/) {
		print "$prefix\[\n";
		&parse_tree($_) foreach (@$xml_tree);
		print "$prefix]\n";
	    }
	    when (/HASH/) {
		print "$prefix\{\n";
		foreach (keys %$xml_tree) {
		    print "$prefix$separator$_ => ";
		    print "$xml_tree->{$_}\n";
		    #&parse_tree($xml_tree->{$_})
		}
		print "$prefix\}\n";
	    }
	    when (/^\s*$/m) {}
	    default { print $prefix,$xml_tree,"\n"; }
	}
    } elsif ($xml_tree) {
	print $prefix,$xml_tree,"\n" unless ($xml_tree =~ /^\s*$/m);
    }
    substr($prefix,-1,1,"");
    # print ref $xml_tree,"\n";
    # if ('ARRAY' eq ref $xml_tree) {
    # 	print $_\n" foreach (@$xml_tree);
    # }
}
