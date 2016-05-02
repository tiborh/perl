#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Formats - Text Slices";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Cutting a long text into slices.</p>
EOT
my $text = "Rock!Hip Hop!Pop!";
    print "<p>The sample text: $text</p>\n";
    my $breakable_characters = $:;
    $: = "";			# the list of characters at which the text can be broken
    print "<pre>\n";
format = 
Led Zeppelin: ^<<<<
            $text
Eninem: ^<<<<<<<
            $text
Pink: ^<<<
            $text
.
write;
$: = $breakable_characters;
    print "</pre>\n";


}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
