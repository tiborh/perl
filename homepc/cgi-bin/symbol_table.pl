#!/usr/bin/perl -w
#use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Using the Symbol Table";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Getting references from the Symbol Table, which is a hash of data (name{type}).</p>
<p><b>Note:</b> It does not work with <code>strict</code> pragma and lexical (<code>my</code>) variables.</p>
EOT
    {
	my $variable = "A scalar reference.";
	my $reference = \$variable;
	print "<p>Dereferencing the reference: $$reference<br />\n";
	print "The reference to the variable: $reference</p>\n";
    }
    {
	print "<p>Doing the same using the symbol table:<br />\n";
	$ScalarRef = *variable{SCALAR};
	print "Dereferencing the reference: $$ScalarRef<br />\n";
	print "The reference to the variable: $ScalarRef</p>\n";
    }
    {
	print "<p>Assigning a new value to the variable:<br />\n";
	${*variable{SCALAR}} = "A new scalar value.";
	print "Dereferencing the reference: $$ScalarRef<br />\n";
	print "The reference to the variable: $ScalarRef</p>\n";
    }
    {
	@array = qw(a reference to an array);
	print "<p>Creating a reference to an array:<br />\n";
	$ArrayRef = *array{ARRAY};
	print "Dereferencing the reference: @$ArrayRef<br />\n";
	print "The reference to the array: $ArrayRef</p>\n";
    }
    {
	%hash = qw(
Day Sun
Night Moon
);
	print "<p>Creating a reference to an array:<br />\n";
	$HashRef = *hash{HASH};
	print "Dereferencing the reference to a key/value: $$HashRef{'Night'}<br />\n";
	print "The reference to the hash: $HashRef</p>\n";
    }

    {
	sub code {
	    print "Some code reference.";
	}
	print "<p>Creating a reference to a subroutine:<br />\n";
	$CodeRef = *code{CODE};
	print "Dereferencing the reference:<br />\n";
	&$CodeRef;
	print "<br />\n";
	print "The reference to the sub: $CodeRef</p>\n";
    }
    {
	my $fn = "file.txt";
	open(FILE,">",$fn) or die "Cannot open file $fn for writing, $!";
	print "<p>Creating a reference to IO (to handle a file):<br />\n";
	$IORef = *FILE{IO};
	my $ftxt = "A file handle reference.";
	print $IORef $ftxt."\n";
	close($IORef);
	print "The following has been written to file $fn: $ftxt<br />\n";
	print "The reference to IO: $IORef</p>\n";
    }
}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
