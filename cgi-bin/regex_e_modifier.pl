#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "regex e modifier";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>e postmodifier makes it possible to place functions into the substitution part</p>
EOT

my $string = "Monday Tuesday Wednesday Thursday Friday";
    print "<p>The original string:<br/>\n$string</p>\n";

    $string =~ s/(\w+)/uc($1)/ge;
    print "<p>The string after the substitution:<br/>\n$string</p>\n";

    $string = "Monday Tuesday Wednesday Thursday Friday";
    $string =~ s/(day)/uc($1)/ge;
    print "<p>The string after the substitution:<br/>\n$string</p>\n";


    $string = "Back to the future.";
    print "<p>The original string:<br/>\n$string</p>\n";
    $string =~ s/(\w+\s)/&subroutine($1)/ge;
    print "<p>The string after the substitution:<br/>\n$string</p>\n";


sub subroutine {
    my $match = shift;
    $match =~ s/Back /In/;
    return $match;
}

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
