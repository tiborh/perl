#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Output Field Separators";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>\$, can be set to a char or to a number of chars.</p>
<p>\$\" is the same but is used for arrays.</p>
EOT

$, = ":";

print "<p>comma separated strings in print:<br />\n";
print "avocado","broccoli","carrot","</p>\n";

    print "<p>list of numbers in print:<br />\n";
    print (1..10);
    print "</p>\n";

    # for arrays, default is space
    my @array = qw(apples oranges bananas);
    print "<p>Printing an array:<br />\n@array</p>\n";
    $" = ";";
    print "<p>Printing it again after setting the array separator:<br />\n@array</p>\n";

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
