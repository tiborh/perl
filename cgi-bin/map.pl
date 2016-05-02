#!/usr/bin/perl -w
use strict;

&cgi_head("Map");
{
    my @numbers = (65..90);
    {
	print("<h1>Map: number to char</h1>\n");
	print "<p>@numbers</p>\n";
	my @chars = map(chr, @numbers);
	print "<p>@chars</p>\n";
    }
    {
	print("<h1>Map: add to number and to char</h1>\n");
	print "<p>@numbers</p>\n";
	map {$_+=32} @numbers;
	print "<p>@numbers</p>\n";
	my @chars = map(chr, @numbers);
	print "<p>@chars</p>\n";
    }
}

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
