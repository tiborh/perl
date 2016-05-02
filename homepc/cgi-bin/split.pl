#!/usr/bin/perl -w
use strict;
#use utf8;
#binmode STDOUT, ":utf8";

&cgi_head("Functions: split");

{
    print "<h1>The split function</h1>\n";
    my $a_string = "'Irrationally held truths may be more harmful than reasoned errors.'";
	print "<p>The string used for splitting:<br />\n";
	print "$a_string</p>\n";
    {
	print "<h2>The string split into three strings</h2>\n";
	my ($w1,$w2,$w3) = split(/ /,$a_string);
	print "<dl>\n";
	print "\t<dt>w1:</dt>\n";
	print "\t\t<dd>$w1</dd>\n";
	print "\t<dt>w2:</dt>\n";
	print "\t\t<dd>$w2</dd>\n";
	print "\t<dt>w3:</dt>\n";
	print "\t\t<dd>$w3</dd>\n";
	print "</dl>\n";
    }
    {
	print "<h2>The string split into an array</h2>\n";
	my (@the_words) = split(/ /,$a_string);
	print "<p>The array:<br />\n";
	print "<ol>\n";
	print "\t<li>$_</li>\n" foreach (@the_words);
	print "</ol>\n";
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
