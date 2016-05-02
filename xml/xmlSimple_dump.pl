#!/opt/perl/bin/perl -w

use strict;
use XML::Simple;
use Data::Dumper;

print "Checking if xml is valid for XML::Simple\n";
&read_xml_and_dump;

sub read_xml_and_dump {
    my $fn = "./var_to_xml.xml";
    my $theYear = XMLin($fn);
    
    print Dumper($theYear);
}
