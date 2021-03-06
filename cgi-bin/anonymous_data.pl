#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Anonymous arrays, hashes and subroutines";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>They are the foundations to complex data structures.</p>
EOT

my $reference = ["an", "anonymous", "array"];
    print "<p>printed out: @$reference</p>\n";
    print "<p>only one item printed out: $$reference[1]</p>\n";

    $reference = {
	'Hello' => 'Goodbye',
	'Hola' => 'Adios'
    };
    print "<p>a value to a key of an anonymous hash is printed: $$reference{'Hola'}</p>\n";

    $reference = sub {
	print "An anonymous subroutine.\n";
    };

    print "<p>Executed:<br />\n";
    &{$reference};
    print "</p>\n";

}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
