#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Copying a Data Structure";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>normal copy is not a copy but the same thing: Storable module can be used to make a true independent copy.</p>
EOT

use Storable qw(dclone);
use Data::Dumper;

my @array = (
    ["shoes","boots","clogs"],
    ["hat","scarf","cap"],
    ["jacket","coat","umbrella"]
);

    print "<p>The array dumped:</p>\n";
    print "<pre>\n";
    print Dumper(\@array);
    print "</pre>\n";
    my @copy = @array;

    my $changed_item = "jersey";
    print "<p>Changing element [2][1] to $changed_item.</p>\n";
    $copy[2][1] = $changed_item;

print "<p>changed element in the copy: $copy[2][1]</p>\n";
print "<p>changed element in the original array: $array[2][1]</p>\n";

    $copy[2][1] = "coat";

    print "<p>Doing the same with <code>dclone(arrayref)</code>:</p>\n";

    @copy = dclone(\@array);

    $copy[2][1] = $changed_item;

    print "<p>changed element in the copy: $copy[2][1]</p>\n";
    print "<p>changed element in the original array: $array[2][1]</p>\n";


} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
