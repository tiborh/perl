#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";
use 5.010;

my $title = "Subroutines - The Scope of Variables (my and local)";

sub main {
    print <<EOT;
<h1>$title</h1>
<p><code>my</code> localises the variable to the block where it is used.</p>
<p><code>local</code> makes a copy of the already existing variable.</p>
<p><code>state</code> variable preserves its value from call to call (but needs <code>use 5.010;</code>)</p>
EOT

print "<p>state: ",&printit,"</p>\n" foreach (1..5);

sub printit {
    state $statevalue;
    return ++$statevalue;
}

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
