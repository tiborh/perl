#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    print "<p>For the usage of <tt>index()</tt> and <tt>rindex()</tt> see <a href='substring.pl'>substring.pl</a>.</p>\n";
}

&cgi_head("Functions: (r)index");
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
