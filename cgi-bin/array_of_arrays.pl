#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Array of Arrays";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Multidimensional arrays are anonymous arrays inside an array.</p>
<h2>2D arrays</h2>
EOT

use Data::Dumper;

    {
	my @array = (
	    ["Jim", "Sam", "Bob"],
	    ["Car", "Truck", "Bicycle"],
	    ["Chef", "Quarry", "Office"]
	    );
	
	print "<p>Printing the whole array is not simple:<br />\n";
	print "@array</p>\n";
	print "<p>The array dumped:</p>\n";
	print "<pre>\n";
	print Dumper(\@array);
	print "</pre>\n";
# accessing one element
	print "<p>Accessing a single element: $array[0][0]</p>\n";

    # another way to create the array:

    # $array[0] = ["Jim", "Sam", "Bob"];
    # $array[1] = ["Car", "Truck", "Bicycle"];
    # $array[2] = ["Chef", "Quarry", "Office"];

    # accessing array in loops:
    print "<p>Accessing the elements in two foreach loops:</p>\n";
    print "<pre>\n";
    foreach my $line (@array) {
	foreach (@$line) {
	    print "$_\t";
	}
	print "\n";
    }
    print "</pre>\n";
    }
    {
	# 3D arrays
	print <<EOT;
<h2>3D arrays</h2>
<p>Each new dimension adds to the complexity, that is, to the depth of indexing and looping through them.</p>
<p>As the complexity increases, the more difficult it becomes to print out the whole array (meaningfully) in the 2D space.</p>
EOT
	my @array = (
	    [
	     ["Jim", "Sam", "Bob"],
	     ["Carls", "Brooks", "Nash"]
	    ],
	    [
	     ["Car", "Truck", "Bicycle"],
	     ["Nissan", "Volvo", "Swallow"]
	    ],
	    [
	     ["Chef", "Driver", "Designer"],
	     ["Hotel", "Quarry", "Office"]
	    ]
	    );
	print "<p>The array dumped:</p>\n";
	print "<pre>\n";
	print Dumper(\@array);
	print "</pre>\n";
	print "<p>Accessing the elements in three foreach loops:</p>\n";
	print "<pre>\n";
	foreach my $first (@array) {
	    foreach my $second (@$first) {
		foreach (@$second) {
		    print "$_\t";
		}
		print "\n";
	    }
	    print "\n";
	}
	print "</pre>\n";
	# the constituent anonymous arrays can be bound to references
	my $names = $array[0];
	print "<p>The names:</p>\n";
	print "<pre>\n";
	print "@$_\n" foreach (@$names);
	print "</pre>\n";
	my $first_names = $array[0][0];
	print "<p>The first names: @$first_names</p>\n";
    }

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
