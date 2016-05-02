#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Regex - Assertions";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>\\b: word boundary. e.g. s/\\b\\b/1st/ inserts the \'1st\' in front of the string.</p>
<p>\\B: non-word boundary (wherever word boundary isn\'t)</p>
<p>^: beginning of line (even inside a string, when a \\n is found)</p>
<p>\$: end of the line (even inside a string, when a \\n is found)</p>
<p>\\A: beginning of the string</p>
<p>\\Z: end of string before the end of line char</p>
<p>\\z: end of the string, after the newline char</p>
EOT



} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
