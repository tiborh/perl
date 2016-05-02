#!/usr/bin/perl -w

use strict;
use Cwd;
use Time::Piece;
use File::Basename;
use Getopt::Std;
use v5.14;

my $DEBUG = 0;

my $out_filename = "output.sgml";

&write_to_file($out_filename);
&print_out_file($out_filename);

sub write_to_file{
    use IO::File;
    my $ofn = shift;
    my $ofh = new IO::File(">$ofn");
    
    use XML::Writer;
    my $writer = new XML::Writer( OUTPUT => $ofh );
    
    #$writer->xmlDecl( 'UTF-8' );
    $writer->doctype( 'seif', 'PUBLIC', '-//ERICSSON//DTD SEIF 1/FAD 110 02 R1//EN' );
    # $writer->comment( 'My happy little HTML page' );
    # $writer->pi( 'foo', 'bar' );
    $writer->startTag( 'seif', 'toc-level' => 'toc2','table-caption' => 'tc-no' );
    # $writer->startTag( 'body' );
    # $writer->startTag( 'h1' );
    # $writer->startTag( 'font', 'color' => 'green' );
    # $writer->characters( "&lt;Hello World!>" );
    # $writer->endTag(  );
    # $writer->endTag(  );
    # $writer->dataElement( "p", "Nice to see you." );
    # $writer->endTag(  );
    $writer->endTag(  );
    $writer->end(  );
}

sub print_out_file{
    my $fn = shift;
    my $fh;
    my $fm = "<";
    open($fh,$fm,$fn) or die "Cannot open file $fn, $!";
    print while (<$fh>);
    close($fh);
}
