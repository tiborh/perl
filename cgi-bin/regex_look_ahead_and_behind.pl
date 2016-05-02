#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Regex - Look Ahead and Look Behind Assertions";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Returns true or false depending on whether what was specified should appear before or after the match is found or not.</p>
<p></p>
EOT

my $string = "Monday Tuesday Wednesday Thursday Friday\n";
    print "<p>The original string:<br/>\n$string</p>\n";

    print "<p>Positive lookahead: there is a Monday (immediately) followed by a space and a Tuesday.</p>\n" if ($string =~ m/Monday\s(?=Tuesday)/); # it matches a Monday which is followed by a Tuesday

    print "<p>Negative lookahead: there is no Monday (immediately) followed by a space and Thursday.</p>\n" if ($string =~ m/Monday\s(?!Thursday)/); # it matches a Monday which is not followed by a Thursday

    print "<p>Positive lookbehind: there is a Tuesday preceded (immediately) by a Monday and a space.</p>\n" if ($string =~ m/(?<=Monday)\sTuesday/); # it matches a <space>Tuesday which is preceded by a Monday

    print "<p>Negative lookbehid: there is no Tuesday preceded (immediately) by a Sunday and a space.</p>\n" if ($string =~ m/(?<!Sunday)\sTuesday/); # it matches a <space>Tuesday which is not preceded by a Sunday

    print "<p>We have a Monday with a Thursday somewhere behind it.</p>\n" if ($string =~ m/Monday(?=.*Thursday)/);
    print "<p>We have no Thursday with a Monday somewhere behind it.</p>\n" if ($string =~ m/Thursday(?!.*Monday)/);
    # variable length lookbehind is not implemented:
    # print "We have a Thursday preceded by a Monday.\n" if ($string =~ m/(?<=.*Monday)Thursday/);
    # a workaround:
    print "<p>A Thursday has been found with a Monday somewhere before it.</p>\n" if ($string =~ m/Monday.*\KThursday/);
    if ($string =~ m/Sunday.*\KThursday/) {
	print "<p>We have a Thursday somewhere before which there is a Sunday.</p>\n";
    } else {
	print "<p>There is no Thursday which is preceded by a Sunday.</p>\n"
    }
    


} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
