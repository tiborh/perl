#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>Handling input/output files</h1>\n";
	my $fh;
	my $fn = "test.txt";
	{
	    print "<h2>Ways of reading a file</h2>\n";
	    print "<ol>\n";
	    print "\t<li>Simply <tt>print()</tt>-ing out <tt>&lt;FILEHANDLER></tt></li>\n"; # This did not work when tested (print <$fh>;)
	    print "\t<li>Reading <tt>&lt;FILEHANDLER></tt> into an array.</li>\n";
	    print "\t<li>Reading <tt>&lt;FILEHANDLER></tt> line by line in a <tt>while</tt> loop.</li>\n";# This did not work when tested (print $_ while (<$fh>);) 
	    print "</ol>\n";
	}
	{
	    my $fm = "<";	# if not given, default is for "read"
	    open($fh,$fm,$fn) or die "unable to open $fn, $!";
	    flock($fh,123);	# file lock
	    print "<p>File <tt>$fn</tt> opened successfully.</p>\n";
	    print "<p>The lines of the file:</p>\n";
	    print "<ol>\n";
	    my @input_array = <$fh>;
	    while ($_ = shift @input_array) {
		chomp;
		print "\t<li>$_</li>\n"; #unless (/^\s*$/);
	    }
	    print "</ol>\n";
	    close($fh);
	}
	{
	    print "<h2>Appending to a file</h2>\n";
	    print "<p>Opening the file...</p>\n";
	    my $app_string = "\nA wise man will make more opportunities than he finds.\n   Sir Francis Bacon\n";
	    my $fm = "+>>";	# read/append
	    open($fh,$fm,$fn) or die "unable to open $fn, $!";
	    flock($fh,123);	# file lock
	    print "<p>File <tt>$fn</tt> opened successfully.</p>\n";
	    print $fh $app_string;
	    print "<p>Appended to the file:<br />$app_string</p>";
	    #close($fh);
	    #open($fh,'<',$fn) or die "unable to open $fn, $!";
	    print "<p>The lines of the file after append:</p>\n";
	    seek($fh,0,0); # rewinding the file
	    print "<ol>\n";
	    my @input_array = <$fh>;
	    while ($_ = shift @input_array) {
		chomp;
		print "\t<li>$_</li>\n"; #unless (/^\s*$/);
	    }
	    print "</ol>\n";
	    close($fh);
	}
    }
}

&cgi_head("file handling");
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
