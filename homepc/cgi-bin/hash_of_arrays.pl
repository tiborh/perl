#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Hash of Arrays";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>For storage of a number of records to a hash key.</p>
EOT

use Data::Dumper;

my %hash = (
    name => ["Tim", "Kim", "Rin"],
    job => ["Student","Design","Circus"],
    pet => ["Dog","Cat","Lion"]
);

    print "<p>Dumping the hash content:</p>\n";
    print "<pre>\n";
    print Dumper(\%hash);
    print "</pre>\n";

    print "<p>Accessing individual data items:<br />\n";
    print "The first name: $hash{name}[0]<br />\n";
    print "The third job: $hash{job}[2]</p>\n";

    print "<p>The data can also be accessed thru a reference:<br />\n";
    my $ref = \%hash;
    print "The first pet: $$ref{pet}[0]</p>\n";

    print "<p>New data can be added either as an anonymous array, or by pushing array items to a key identified anon array.</p>\n";
    $hash{id} = ["123","456","789"];
    push @{$hash{transport}},"Bike","Bus","Lion back";

    print "<p>The whole data structure can be looped with for/foreach combinations:</p>\n";
    print "<pre>\n";
    for my $key (keys %hash) {
	print "$key - @{$hash{$key}}\n";
    }
    print "\nor\n\n";
    for my $key (keys %hash) {
	print "$key:\n";
	print "\t$_\n" foreach (@{$hash{$key}});
    }
    print "</pre>\n";

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
