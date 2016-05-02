#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>rand(&lt;int>)</h1>\n";
	print "<p>The function returns a float between zero and &lt;int>, which can be converted into an integer if necessary.</p>\n";
	my @an_array = qw(月 火 水 木 金 土 日);
	{
	    print "<h2>Creating random numbers</h2>\n";
	    print "<p>Selecting a weekday based on random numbers.</p>\n";
	    print "<ol>\n";
	    print "\t<li>",$an_array[int rand(@an_array)],"</li>\n" foreach (1..10);
	    print "</ol>\n";
	}
	{
	    print "<h2>Collecting results into a hash</h2>\n";
	    my %coll_hash = ();
	    my $maxnum = 10000;
	    $coll_hash{@an_array[int rand(@an_array)]}++ foreach (1..$maxnum); # undef is handled as zero
	    print "<p>The result of $maxnum generations:</p>\n";
	    print "<ol>\n";
	    printf("\t<li>%s: %d (%.0f%%)</li>\n",$_,$coll_hash{$_},($coll_hash{$_}/$maxnum)*100) foreach (keys %coll_hash);
	    print "</ol>\n";
	}
    }
}

&cgi_head("Functions: rand");
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
