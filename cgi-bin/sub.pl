#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $test_variable = "<i>Blame someone else and get on with your life.</i>";

sub main {
    {
	print "<h1>Basic facts about subroutines</h1>\n";
	print "<ol>\n";
	print "<li>When calling a subroutine, it inherits the global variables.<br />\n";
	&testing;
	print "</li>\n";
	print "<li>The last line of the subroutine gives the return value:<br />\n";
	print &testing,"</li>\n";
	print "</ol>\n";
    }
}

sub testing {
    print $test_variable,"<br />\n";
    my $result = "<i>There's no point in being grown up if you can't be childish sometimes.</i>";
}

&cgi_head("subroutines");
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
