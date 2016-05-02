#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    print <<EOT;
<h1>Perl Package Manager</h1>
<p>PPP is a part of active perl. Not available in other distributions.</p>
EOT
}

require "html.cgi";

&cgi_head("Perl Package Manager");
&main();
#&printcode($0);
&cgi_foot();
exit;
