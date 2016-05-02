#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Regex - Alternative Match Patterns";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>|: the bar character means \"or\": e.g. m/blue|green|red/i m/[A-Z]|[0-9]/ m/^(cat|dog|horse)\$/</p>
EOT



} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
