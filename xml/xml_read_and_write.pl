#!/usr/bin/perl -w

use strict;
use XML::Simple;

die "Usage: $0 <input.xml> <output.xml>\n" if (scalar @ARGV < 2);
my $fn_in = $ARGV[0];
my $fn_out = $ARGV[1];
die "Filename $fn_in does not exist.\n" unless (-e $fn_in);

print "Reading file...\n";
&read_xml_and_write($fn_in,$fn_out);

sub read_xml_and_write {
    my $fn_in = $_[0];
    my $fn_out = $_[1];
    my $theYear = XMLin($fn_in, ForceArray => 1, KeepRoot => 1);
    
    write_xmlout($fn_out,$theYear);
}

sub write_xmlout() {
    my $fh;
    my $fm = ">";
    my $fn = $_[0];
    open ($fh,$fm,$fn) or die "Unable to open file $fn.\n $!";
    my $xml = XMLout($_[1], OutputFile => $fh, KeepRoot => 1);
    close $fh;
    print "Structure has been written to $fn.\n";
    return;
}
