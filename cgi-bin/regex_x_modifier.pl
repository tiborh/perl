#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Regex - x modifier";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>x modifier helps readability of regex expressions</p>
EOT

my $string = "I have 8 + 4 dollars and 50 / 2 cents.";
    print "<p>The original string:<br/>\n",$string,"</p>\n";
    $string =~ s{(\d+\s*[+*/-]\s\d+)}{$1}eeg;
    print "<p>The string after substitution:<br/>\n",$string,"</p>\n";


    # easier to read format with x (with linebreaks, white spaces, and comments:
    $string =~ s{
                   (
                      \d+	#digits 
                      \s*	# whitespace
                      [+*/-]	# etc.
                      \s
                      \d+
                   )
                }
                {$1}eegx;


} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
