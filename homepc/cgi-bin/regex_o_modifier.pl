#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Regex - o modifier";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>The o modifier prevents the variable to change.</p>
EOT

# my $word = "Hello";
#     while (<>) {
# 	print "(The word: $word)\n";
# 	if (/$word/o) {
# 	    print  "Yes!\n";
# 	    $word = "Goodbye!\n"; # with the o modifier, this line is ineffective
# 	} else {
# 	    print "No!\n" ;
# 	}
#     }

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
