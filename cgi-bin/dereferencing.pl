#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Dereferencing";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>There are two ways to dereference a reference:</p>
<ol>
<li>putting the variable type to the front:<br />
e.g. \@\$reference for an array or \&\$reference for a subroutine</li>
<li>using the arrow (->) operator at the end:<br />
e.g. \$reference->{key} for a hash or \$reference->[0]->[1] for an array in an array<br />
(the latter can be simplified as: \$reference->[0][1])</li>
</ol>
EOT
    use Data::Dumper;
    {
	my @array = qw(an array of data);
	my $reference = \@array;
	print "<p>An array item dereferenced in the first way: @$reference[1]<br />\n";
	print "and in the second way: $reference->[1]<br />\n";	# no need to give the data type at the front
	print "(the whole array: @array)</p>\n";
    }
    {
	my %hash = qw(
North South
East West
);
	my $reference = \%hash;
	print "<p>Hash key/value referenced with arrow: $reference->{'North'}</p>\n";
	print "<p>The whole hash dumped:</p>\n";
	print "<pre>\n";
	print Dumper($reference);
	print "</pre>\n";
    }
    {
	sub code {
	    print shift;
	}
	my $reference = \&code;
	print "<p>Subroutine referenced and argumented with arrow reference:<br />\n";
	$reference->("A subroutine reference");
	print "</p>\n";
    }
    {				
	# array reference
	my $anon_array_ref = ["A", "B", "C"];
	print "<p>Array referenced with an arrow: $anon_array_ref->[2]</p>\n";
	
	# arrays within an array
	$anon_array_ref = [["A", "B", "C"],["D", "E", "F"]];
	print "<p>Arrays within an array:</p>\n";
	print "<pre>\n";
	print Data::Dumper->Dump([$anon_array_ref]);
	print "</pre>\n";
	print "<p>the second array: @{$anon_array_ref->[1]}<br />\n";
	print "only one letter from an array: $anon_array_ref->[1]->[2]<br />\n";
	print "reference simplified: $anon_array_ref->[1][2]</p>\n";

        # array of arrays
	my @array = (["A", "B", "C"],["D", "E", "F"]);
	print "<p>The array handled as a multidimensional $array[0][1]</p>\n";
    }
}





require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
