#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>Case shifting functions</h1>\n";
	my $rest_unchanged = "<p>(It leaves the rest unchanged.)</p>\n";
	{
	    print "<h2>uc</h2>\n";
	    my $sample_string = "a wise man will make more opportunities than he finds.";
	    print "<p>$sample_string</p>\n";
	    print "<p>",uc($sample_string),"</p>\n";
	}
	{
	    print "<h2>lc</h2>\n";
	    my $sample_string = "A WISE MAN WILL MAKE MORE OPPORTUNITIES THAN HE FINDS.";
	    print "<p>$sample_string</p>\n";
	    print "<p>",lc($sample_string),"</p>\n";
	}
	{
	    print "<h2>ucfirst</h2>\n";
	    my $sample_string = "a wise man will make more opportunities than he finds.";
	    print "<p>$sample_string</p>\n";
	    print "<p>",ucfirst($sample_string),"</p>\n";
	    print $rest_unchanged;
	}
	{
	    print "<h2>lcfirst</h2>\n";
	    my $sample_string = "A WISE MAN WILL MAKE MORE OPPORTUNITIES THAN HE FINDS.";
	    print "<p>$sample_string</p>\n";
	    print "<p>",lcfirst($sample_string),"</p>\n";
	    print $rest_unchanged;
	}
	{
	    print "<h2>ucfirst and lc combined with split, map, and join</h2>\n";
	    my $sample_string = "the title of a song";
	    print "<p>$sample_string</p>\n";
	    print "<p>",join(' ', map({ucfirst} split(/ /, $sample_string))),"</p>\n";
	}
    }
}

&cgi_head("Functions: uc, lc, ucfirst, lcfirst");
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
