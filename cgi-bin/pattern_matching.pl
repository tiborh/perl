#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Pattern Matching";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Prematch and Postmatch.</p>
EOT

my $string = "PrematchMatchPostmatch";
    $string =~ /Match/; 	# m//

    print "Match: $&\n";	# predifined match variable
    print "Prematch: $`\n";	# prematch
    print "Postmatch: $'\n";	# postmatch
    print "The whole string: $`$&$'\n";


} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
