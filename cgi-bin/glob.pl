#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>The glob() function</h1>\n";
	print "<p>A glob can be obtained in several ways:</p>\n";
	print "<ol>\n";
	print "<li><tt>while(<[path/]*[.extension]>)</tt></li>\n";
	print "<li><tt>\@array = glob([path/]*[.extension])</tt> (it can be printed out directly, too: <tt>join(\"\\n\",glob(...))</tt>)</li>\n";
	print "</ol>\n";
    }
}

&cgi_head("functions: glob");
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
