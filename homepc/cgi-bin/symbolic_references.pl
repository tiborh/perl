#!/usr/bin/perl -w
#use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Symbolic References";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>They do not hold the address, but only the name to the data item.</p>
<p><b>Note:</b> it does not work with \"strict\" pragma and \"my\" (lexical) variables.</p>
EOT
    {
	$variable = "A string of text.";
	$reference = "variable";
	print "<p>Derefernced symbolic reference to a variable: $$reference</p>\n";
    }

    {
	@array = (1..10);
	$reference = "array";
	print "<p>Derefernced symbolic reference to an array: @$reference</p>\n";
    }

    {
	%hash = qw(
English Hello
French  Bonjour
);
	$reference = "hash";
	print "<p>Derefernced (a key): $$reference{'English'}</p>\n";
    }

    {
	$reference = "subroutine";
	print "<p>Running the subroutine (by dereferencing):<br />\n";
	
	&$reference;
	print "</p>\n";

	sub subroutine {
	    print "I'm a subroutine!";
	}
    }

}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
