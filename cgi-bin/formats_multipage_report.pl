#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Formats - Multipage Report";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Creating a multipage report from a text file.</p>
<p>There is only one difference from <a href=\'formats_document_header.pl\'>formats_document_header.pl</a>: in the header, you need to place a \"Page \$\%\" line for pagenumbers.</p>
<p>Another optional difference is the line numbers per page: e.g. \$= = 50 (the default is 60).</p>
EOT
}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
