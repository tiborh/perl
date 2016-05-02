#!/usr/bin/perl -w
use strict;

&cgi_head("Grep");
{
    my @numbers = (0..100);
    print("<h1>Grep: get even out</h1>\n");
    print "<p>@numbers</p>\n";
    my @even_numbers = grep {$_ % 2 == 0} @numbers;
    print "<p>@even_numbers</p>\n";
}
{
    print("<h1>Grep: get f words out</h1>\n");
    my @words = qw(one two three four five six seven eight nine ten);
    print "<p>@words</p>\n";
    my @fwords = grep {/f/} @words;
    print "<p>@fwords</p>\n";
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
