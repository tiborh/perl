#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Regex - Match Characters";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Matching a character: digit, letters, etc.</p>
<p>match operator \'m\' is not obligatory</p>
<p>separators do not have to be slashes.</p>
<p>i: case insensitive</p>
<p>g: global (all)</p>
<p>\\d: digit</p>
<p>\\w: word character</p>
<p>\\s: white space</p>
<p>\\b: word boundary: e.g. \b\w[4]\b (pick out any 4-letter word)</p>
<p>+: one or more occurrence of previous</p>
<p>*: zero or more occurrence</p>
<p>?: zero or one occurrence</p>
<p>.: any one character</p>
EOT



} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
