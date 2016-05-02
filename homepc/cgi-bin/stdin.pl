#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Using STDIN to get typed input";

sub main {
    print <<EOT;
<h1>$title</h1>
<p><code>STDIN</code> is used to get input from user.</p>
<p>Most commonly it is used inside the diamond operator and in a while loop.</p>
EOT

# echo:
# while (<STDIN>) {
#     print;
# }

#minimalist echo:
#print while (<>);

# simple user input:
# print "Type First Name: ";
#     my $c = 1;
#     while (<>) {
# 	for ($_) {
# 	    if ($c == 1) {print "Type Surname Name: ";}
# 	    else {print "Thanks!\n"; exit;}
# 	}
# 	$c++;
#     }

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
