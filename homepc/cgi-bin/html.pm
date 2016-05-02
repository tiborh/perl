package MyHtml v0.0.1 {
    use v5.14;
    use utf8;
    use CGI;
    binmode(STDOUT, ":utf8");
    sub printcode{
	my $fn = shift;
	my $cgo = shift;
	my $title = shift || "Code listing";
	my $fh;
	open ($fh,'<:encoding(UTF-8)',$fn) or die "Cannot open $fn, $!";
	my $collector = "";
	foreach (<$fh>) {
	    s/&/&amp;/g;
	    s/</&lt;/g;
	    $collector .= $_;
	}
	close($fh);
	say $cgo->hr;
	say $cgo->h1($title);
	say $cgo->pre($collector);
	return;
    }
}
1;
