#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>Search Results</h1>\n";

	my $buffer = $ENV{'QUERY_STRING'};
	my @pairs = split(/&/, $buffer);
	my %query = ();
	foreach my $pair (@pairs) {
	    my ($name,$value) = split(/=/, $pair);
	    $value =~ tr/+/ /;
	    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
	    $value =~ s/~!/ ~!/g;
	    $query{$name} = $value;
	}

	my $SearchTerm = exists($query{'q'}) ? $query{'q'} : "nothing";
	my $Location = exists($query{'l'}) ? $query{'l'} : "nowhere";

	print <<EOF;
<p>You searched '$Location' 
for '$SearchTerm'<br />
100 results found!<br />
Result 1<br />
Result 2<br />
Result 3<br />
etc...
</p>
EOF
    }
}

&cgi_head("search results");
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
