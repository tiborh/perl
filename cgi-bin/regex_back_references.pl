#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Regex - back references";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>refers back to groups of matches by number</p>
<p>e.g. s/(\\d\\d\\d)-(\\d\\d\\d)-(\\d\\d\\d)/\\3-\\2-\\1/,<br />
but it is better to do that with \$1, \$2, and \$3,<br />
e.g. s/(\\d\\d\\d)-(\\d\\d\\d)-(\\d\\d\\d)/\$3-\$2-\$1/ ) with recent versions of Perl,<br />
the backslashed number are usually limited to the left hand side, in the pattern match.<br />
e.g. m/(\\w)(\\w)\\2\\1/ will match strings like \'abba\'</p>
<p>Outside the match or substitution fields, even in old versions of perl, the dollar/number combo version is used. e.g. m/&lt;(b|i)>[\w\s\.]+&lt;\/b>/ later referring back to the b|i option, \$1 is used.</p>
EOT



} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
