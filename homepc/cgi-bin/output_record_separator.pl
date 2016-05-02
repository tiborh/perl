#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Output Record Separator";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>\$\\ printed each time the print operation is used, after the printed output.</p>
EOT
{
# without the separator
    print "<p>Without the operator, the best way is perhaps a sub:</p>\n";
    print "<pre>\n";
    print "A line of text.\n";
    &hyphens;
    print "Another line of text.\n";
    &hyphens;
    print "One more line of text.\n";
    &hyphens;
    print "</pre>\n";

    sub hyphens {
	print "----------------------\n";
    }
}
{   # using the separator
    print "<p>Using the operator makes life easier, but it needs to be set back to default after it is not used any longer.</p>\n";
    my $saved_sep = $\;
    print "<pre>\n";
    $\ = "----------------------\n";
    print "A line of text.\n";
    print "Another line of text.\n";
    print "One more line of text.\n";
    $\ = $saved_sep;
    print "</pre>\n";
}



} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
