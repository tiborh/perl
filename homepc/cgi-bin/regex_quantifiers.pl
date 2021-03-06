#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Regex - Quantifiers";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>They give how many times the previous character or pattern should match.</p>
<p>Possible variations: {num}, {num,}, {,num}, {num1,num2}</p>
<p>e.g. m/\\b.{5,7}\\b/</p>
<p>*: zero or more times</p>
<p>+: one or more times</p>
<p>?: zero or one time</p>
<p>By default, they are greedy. (Matching as many chars as possible)</p>
<p>To make then non-greedy, apply a question mark after the quantifiear.</p>
<p>e.g. m/l.*?e/</p> 
EOT



} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
