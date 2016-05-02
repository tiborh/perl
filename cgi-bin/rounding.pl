#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>Ways of rounding numbers in Perl</h1>\n";
	print "<ol>\n";
	print "\t<li>If a whole number is needed, use <tt>int()</tt>.</li>\n";
	print "\t<li>If it is for displaying it nicely, use <tt>printf()</tt> or <tt>sprintf()</tt>.</li>\n";
	print "\t<li>The <tt>POSIX</tt> module has <tt>ceil()</tt> and <tt>floor()</tt> in case that's what you need.</li>\n";
	print "</ol>\n";
    }
}

&cgi_head("rounding numbers");
&main();
&cgi_foot();
exit;

sub cgi_head {
print <<"EOT";
Content-type: text/html\n
<!doctype html>
<html lang="en">
<head>
\t<meta charset="utf-8">
\t<title>$_[0]</title>
</head>
<body>
EOT
}

sub cgi_foot {
print <<"EOT";
</body>
</html>
EOT
}
