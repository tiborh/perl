#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Formats - Create Document Header";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Creating a document header.</p>
EOT


format STDOUT_TOP = 
@||||||||||||||||||||||||||||||
"Members of Staff"
First   Last    ID      Phone
-------------------------------
.

    my @FN = qw(John Fred Sarah Ray);
    my @LN = qw(Smith Jones Thomas Biggs);
    my @ID = qw(652 781 167 442);
    my @PH = qw(x23 x54 x7 x18);
    my $c=0;

format STDOUT = 
@<<<<<<<@<<<<<<<@<<<<<<<@<<<<<<<
$FN[$c],$LN[$c],$ID[$c],$PH[$c] 
.
    print "<pre>\n";
while ($c <= $#FN) {
write;
$c++;
}
    print "</pre>\n";
}


require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
