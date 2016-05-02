#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Current Input Line Number";

sub main {
    print <<EOT;
<h1>$title</h1>
<p> \$. for the most recent file handle.</p>
EOT

{
    print "<p>printing first ten or less if file ends sooner lines of on input file:</p>\n";
    my $fh;
    my $fn = "data.txt";
    my $counter = 1;
    my $line;

    # without the line counter
    open($fh,"<",$fn) or die "Cannot open $fn, $!";

    print "<pre>\n";
    while (($line = <$fh>) && ($counter <= 10)) {
	print "$counter:\t$line";
	$counter++;
    }
    print "</pre>\n";
    close($fh);
}
{
    my $fh;
    my $fn = "data.txt";
    my $line;
    print "<p>Doing the same thing using the built-in variable.</p>\n";
    # with the build-in variable: 
    open($fh,"<",$fn) or die "Cannot open $fn, $!";

    print "<pre>\n";
    print "$.:\t$line" while (($line = <$fh>) && ($. <= 10));
    print "</pre>\n";

    close($fh);
}

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
