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

# initialize parser object and parse the string
my $parser = XML::Parser->new( ErrorContext => 2 );
eval { $parser->parsefile( $inXML ); };
 
# report any error that stopped parsing, or announce success
if( $@ ) {
    $@ =~ s/at \/.*?$//s;               # remove module line number
    print STDERR "\nERROR in '$inXML':\n$@\n";
} else {
    print STDERR "'$inXML' is well-formed\n";
}




