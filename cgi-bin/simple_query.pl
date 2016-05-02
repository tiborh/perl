#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>Simple Query String</h1>\n";
	print "<ol>\n";
	print "\t<li>Create a variable and make it equal to the 'QUERY_STRING' environment variable.</li>\n";
	print "\t<li>Split the variable created in the previous step around commas (not forgetting to protect the commas inside //: /\\,/)</li>\n";
	print "\t<li>Now you can call the script url with <tt>?parameter,value</tt> at the end in a browser.</li>\n";
	# my $Query = $ENV{QUERY_STRING};
	# my ($User,$Page)=split(/\,/,$Query);
	print "</ol>\n";
    }
}

# video source: www.berm.co.nz/cgi-bin/video/user.cgi?bermnz,1

&cgi_head("simple query string");
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
