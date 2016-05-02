#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Data Dumper Module";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>To print out simple or complex data structures.</p>
<p>Some examples:</p>
EOT

use Data::Dumper;
    my $sum = 1 + 1;
    print "<pre>\n";
    print Dumper($sum);

    my @array = qw(one two three four five);
    print Data::Dumper->Dump([\@array], [*array]);

my %hash = qw(
name James
age 25
job accountant
);

my @mdarray = (
    ["dance","jump","hop"],
    ["moon","sun","star"],
    ["car","bus","bike"]
    );

    print Data::Dumper->Dump([\@array, \%hash, \@mdarray], [*array, *hash, *mdarray]);
    print "</pre>\n";

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
