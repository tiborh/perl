#!/usr/bin/perl -w
use strict;

&cgi_head("Hash - simple printing");
{
    print("<h1>Hash: print content as array</h1>\n");
    my %a_hash = ();
    %a_hash = (fname => "john", age => 25, city => "london");
    $a_hash{sname} = "doe";
    print "<p>",%a_hash,"</p>\n";
    print "<p>@{[%a_hash]}</p>\n";
}
{
    # a simple way to create hashes:
    my %a_hash = qw(fname john 
                    age 25 
                    city london);
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
