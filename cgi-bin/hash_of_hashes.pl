#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Hash of Hashes";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>For text-based data.</p>
EOT

use Data::Dumper;

my %hash = (
    name => {
	first => 'John',
	family => 'Smith'
    },
    address => {
	street => '23 Booth Crescent',
	city => 'Frankton'
    },
    occupation => {
	main => 'Plumber',
	other => 'Charity Work'
    }
);

    print "<p>Dumping the hash content:</p>\n";
    print "<pre>\n";
    print Dumper(\%hash);
    print "</pre>\n";

    print "<p>Accessing specific data items:<br />\n";
    print "First name: $hash{name}{first}<br />\n";
    print "Street address: $hash{address}{street}</p>\n";

    my $ref = \%hash;
    print "<p>Accessing specific data item with reference:<br />\n";
    print "Main occupation: $$ref{occupation}{main}</p>\n";

    print "<p>Accessing all data in a double for loop:</p>\n";
    print "<pre>\n";
    for my $datatype (keys %hash) {
	print "$datatype\n";
	for my $dataitem (keys %{$hash{$datatype}}) {
	    print "\t$dataitem - $hash{$datatype}{$dataitem}\n";
	}
    }
    print "</pre>\n";

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
