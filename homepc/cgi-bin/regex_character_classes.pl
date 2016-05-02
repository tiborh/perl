#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Regex - Character Classes";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>to match a set of characters</p>
<p>contained in square brackets</p>
<p>e.g. [A-Z], [a-z], [0-9], [A-Za-z], [\\d\\s\\w], [^A-Za-z\.\\s] (negative match)</p>
EOT



} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
