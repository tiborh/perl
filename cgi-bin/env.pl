#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>Environment Variables</h1>\n";
	print '<p>The most commonly used environment variables (<tt>$ENV{<variable>}</tt>):</p>'."\n";
	print "<ul>\n";
	print "\t<li>QUERY_STRING</li>\n";
	print "\t<li>HTTP_REFERER</li>\n";
	print "\t<li>REMOTE_ADDR (IP)</li>\n";
	print "\t<li>REMOTE_HOST (ISP)</li>\n";
	print "\t<li>HTTP_USER_AGENT (browser)</li>\n";
	print "</ul>\n";
    }
    {
	print "<h2>List of Available Environment Variables</h2>\n";
	print "<pre>\n";
	foreach (sort keys %ENV) {
	    print "$_ = $ENV{$_}\n";
	}
	print "</pre>\n";
    }
}

&cgi_head("environment variables");
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
