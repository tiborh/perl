#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>tr///</h1>\n";
	print "<p>The tr// is very useful for multiple simple changes. It replaces the members of a search list to the members of the replacement list.</p>\n";
	print "<p>e.g. tr/a-z/2-7/ ('7' is a catchall)</p>\n";
	print "<p>The starting string:<br />\n";
	my $a_string = "A little inaccuracy sometimes saves tons of explanation.";
	my $cp_string = $a_string;
	print "$a_string</p>\n";
	print "<p>After the replacement:<br />\n";
	$a_string =~ tr/a-z/2-7/;
	print "$a_string</p>\n";
	$a_string = $cp_string;
	print "<p>When the catchall functionality is turned off by deleting those which would fall into that category (d):<br />\n";
	$a_string =~ tr/a-z/2-7/d;
	print "$a_string</p>\n";
	$a_string = $cp_string;
	print "<p>If the complement is converted (c):<br />\n";
	$a_string =~ tr/a-z/2-7/c;
	print "$a_string</p>\n";
	$a_string = $cp_string;
	print "<p>Avoiding repetitions (s):<br />\n";
	$a_string =~ tr/a-z/2-7/s;
	print "$a_string</p>\n";
    }
}

&cgi_head("tr");
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
