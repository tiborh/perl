#!/usr/bin/perl -w

use strict;
use XML::Simple;
use Data::Dumper;

die "Filename is needed as argument\n" if (scalar @ARGV < 1);
my $fn = $ARGV[0];
die "Filename $fn does not exist.\n" unless (-e $fn);

print "Reading file...\n";
&read_xml_and_dump($fn);

sub read_xml_and_dump {
    my $fn = $_[0];
    my $theYear = XMLin($fn);
    
    print Dumper($theYear);
}
