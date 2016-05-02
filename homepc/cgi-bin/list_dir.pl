#!/usr/bin/perl -w
use strict;

my @the_dir = <*>;
print "Content-type: text/html\n\n";
print <<"EOT";
<!doctype html>
<html lang="en">
<head>
\t<meta charset="utf-8">
\t<title>Directory Listing</title>
</head>
<body>
<h1>\udirectory content</h1>
EOT

print "<ul>\n";
foreach (@the_dir) {
    if ($_ !~ /.*~$/) {
	print "\t<li>";
	print((-x -f) ? "<a href='$_'>$_</a>" : "$_");
	print " &lt;dir>" if (-d);
	print "</li>\n";
    }
}
print "</ul>\n";

print <<"EOT";
</body>
</html>
EOT
exit;
