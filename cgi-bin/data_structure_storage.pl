#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    use Storable;
    print <<EOT;
<h1>Storing Data Structures on Disk</h1>
<p>Data structures can be stored with the help of the <code>Storable</code> module.</p>
EOT
    {
	my @array = qw(one two three four five);
	my $fn = "array.txt";
	store(\@array,$fn);
	my @a = @{retrieve($fn)};

	print "<h2>Storing simple data structure (an array)</h2>";
	print "<p>File for storage: <code>$fn</code></p>\n";
	print "<p>Whole array: <code>@a</code></p>\n";
	print "<p>An element of the array: <code>$a[4]</code></p>\n";
    }
    {
	use Data::Dumper;
	my %hash = (
	    colour => {
		'sea' => 'blue',
		'grass' => 'green',
		'sun' => 'yellow'
	    },
	    size => {
		'dog' => 'big',
		'cat' => 'small',
		'mouse' => 'tiny'
	    }
	    );
	my $fn = "hash.txt";
	store(\%hash,$fn);
	my %h = %{retrieve($fn)};

	print "<h2>Storing a complex data structure (hash of hashes)</h2>";
	print "<p>File for storage: <code>$fn</code></p>\n";
	print "<p>An element of the hash (size of the dog): <code>$h{size}{dog}</code></p>\n";
	print "<p>The complex data structure can be printed out with <code>Data::Dumper</code>:</p>\n";
	print "<pre>\n";
	print Data::Dumper->Dump([\%h],[*h]);
	print "</pre>\n";
    }
}



require "html.cgi";

&cgi_head("storing data structure in file");
&main();
&printcode($0);
&cgi_foot();
exit;
