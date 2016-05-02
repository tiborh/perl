#!/usr/bin/perl -w
use strict;

&cgi_head("hash - loop");
{
    my %a_hash = qw(1 一つ 2 二つ 3 三つ 4 四つ 5 五つ 6 六つ 7 七つ 8 八つ 9 九つ 10 十);
    {
	print("<h1>Hash: looping through a hash with while/each</h1>\n");
	print("<ul>\n");
	while (my ($key, $value) = each(%a_hash)) {
	    print("\t<li>$key => $value</li>\n");
	}
	print("</ul>\n");
    }
    {
	print("<h1>Hash: looping through a hash with foreach/(sorted)keys</h1>\n");
	print("<ul>\n");
	foreach my $key (sort {$a <=> $b} (keys %a_hash)) {
	    printf("\t<li>%2d &rArr; %s</li>\n",$key,$a_hash{$key});
	}
	print("</ul>\n");
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
