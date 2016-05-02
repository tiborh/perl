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

sub printcode{
    my $fh;
    my $fn = $_[0];
    my $title = (defined($_[1])) ? $_[1] : "Code listing";
    open ($fh,'<',$fn) or die "Cannot open $fn, $!";
    print "<p><hr /></p>\n";
    print "<p><b>$title</b></p>\n";
    print "<pre>\n";
    foreach (<$fh>) {
	s/&/&amp;/g;
	s/</&lt;/g;
	print;
    }
    print "</pre>\n";
}

return 1;