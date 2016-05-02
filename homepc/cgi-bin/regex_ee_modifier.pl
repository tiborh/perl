#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "regex ee modifier";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>es postmodifier indicates the ther left hand side of the substitution needs to be evalueated as code.</p>
EOT

my $string = "10 + 5";
    print "<p>The original string:<br/>\n$string</p>\n";
    $string =~ s/(\d+ [+*-\/] \d+)/$1/ee; # sum of the two numbers
    print "<p>The string after the substitution:<br/>\n$string</p>\n";

$string = "10 * 5";
    print "<p>The original string:<br/>\n$string</p>\n";
    $string =~ s/(\d+ [+*-\/] \d+)/$1/ee; # sum of the two numbers
    print "<p>The string after the substitution:<br/>\n$string</p>\n";

$string = "10 - 5";
    print "<p>The original string:<br/>\n$string</p>\n";
    $string =~ s/(\d+ [+*-\/] \d+)/$1/ee; # sum of the two numbers
    print "<p>The string after the substitution:<br/>\n$string</p>\n";

$string = '10 / 5';
    print "<p>The original string:<br/>\n$string</p>\n";
    $string =~ s{(\d+ [+*-/] \d+)}{$1}ee; # sum of the two numbers
    print "<p>The string after the substitution:<br/>\n$string</p>\n";

$string = "I have 3 + 6 dollars";
    print "<p>The original string:<br/>\n$string</p>\n";
    $string =~ s{(\d+ [+*-/] \d+)}{$1}ee; # sum of the two numbers
    print "<p>The string after the substitution:<br/>\n$string</p>\n";

$string = "I have 3 + 6 dollars and 10 / 2 cents";
    print "<p>The original string:<br/>\n$string</p>\n";
    $string =~ s{(\d+ [+*-/] \d+)}{$1}ee; # sum of the two numbers
    print "<p>The string after the substitution:<br/>\n$string</p>\n";

$string = "I have 3 + 6 dollars and 10 / 2 cents";
    print "<p>The original string:<br/>\n$string</p>\n";
    $string =~ s{(\d+ [+*-/] \d+)}{$1}eeg; # sum of the two numbers
    print "<p>The string after the substitution:<br/>\n$string</p>\n";

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
