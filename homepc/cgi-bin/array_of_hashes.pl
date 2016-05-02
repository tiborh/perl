#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Array of Hashes";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>For looping thru hashes numerically.</p>
EOT

use Data::Dumper;

my @array = (
    {
	first => 'John',
	family => 'Smith'
    },
    {
	street => '23 Booth Crescent',
	city => 'Frankton'
    },
    {
	main => 'Plumber',
	other => 'Charity'
    }
);

    print "<p>Dumping the array content:</p>\n";
    print "<pre>\n";
    print Dumper(\@array);
    print "</pre>\n";

    print "<p>Accessing individual data items:<br />\n";
    print "First name: $array[0]{first}<br />\n";
    print "Street address: $array[1]{street}</p>\n";

    print "<p>New data can be added either as array/anonymous hash, by pushing an array item of anon hash.</p>\n";
    $array[3] = {wage => '$25ph'};
    push @array, {id => '123'};

    my $ref = \@array;
    print "<p>The data can also be accessed thru a reference:<br />\n";
    print "Main occupation: $$ref[2]{main}</p>\n";

    print "<p>The whole data structure can be looped thru by a foreach/for combo,</p>\n";
    print "<pre>\n";
    foreach my $dtype (@array) {
	for my $key (keys %$dtype) {
	    print "$key = $$dtype{$key}\n";
	}
    }
    print "</pre>\n";

    print "<p>or with two for loops, using array indexes.</p>\n";
    print "<pre>\n";
    for my $line (0..$#array) {
	for my $key (keys %{$array[$line]}) {
	    print "$key = ${$array[$line]}{$key}\n";
	}
	print "\n";
    }
    print "</pre>\n";

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
