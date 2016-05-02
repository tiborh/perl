#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Chop and Chomp";

sub main {
    print <<EOT;
<h1>$title</h1>
<p><code>chomp()</code>: to remove end-of-line breaks. (Extremely useful for dealing with input lines from file or STDIN.)</p>
<p><code>chop()</code>: to remove the last character of a line</p>
EOT



} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
