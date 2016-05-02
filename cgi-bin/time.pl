#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>Handling time in Perl</h1>\n";
	my $the_time = time();
	my $the_localtime = localtime(); # using it directly results in an array of numbers
	my $the_gmt = gmtime(); # using it directly results in an array of numbers
	my @localtime_array = localtime($the_time);
	print "<ol>\n";
	print "\t<li>The function <tt>time()</tt> gives the number of seconds since 1970.01.01.<br />\n\t<tt>$the_time</tt></li>\n";
	print "\t<li>Two easy ways to format it: <tt>localtime</tt> and <tt>gmtime</tt><br />\n\t<tt>$the_localtime</tt><br />\n\t<tt>$the_gmt</tt><br />\n\t(converted into strings.)</li>\n";
	print "\t<li>If the two functions above are used directly, not converted into strings, they return arrays.<br />\n\tFor example, <tt>localtime(time())</tt> (can be <tt>localtime()</tt>, too):<br />\n\t<tt>@localtime_array</tt></li>\n";
	# 0 1 2 3 4 5 6 7 8
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
	my @months = qw(一月 二月 三月 四月 五月 六月 七月 八月 九月 十月 十一月 十二月);
	my @weekdays = qw(日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日);
	my $the_year = $year + 1900;
	my $the_yearday = $yday + 1;
	print "\t<li>Breaking up the array:<br />\n";
	print "\t<ul>\n";
	print "\t\t<li>0: sec</li>\n";
	print "\t\t<li>1: min</li>\n";
	print "\t\t<li>2: hour</li>\n";
	print "\t\t<li>3: month day (one-based)</li>\n";
	print "\t\t<li>4: month (zero-based)</li>\n";
	print "\t\t<li>5: year (1900-based)</li>\n";
	print "\t\t<li>6: week day (zero/Sunday-based)</li>\n";
	print "\t\t<li>7: year day (zero-based)</li>\n";
	print "\t\t<li>8: DST flag<br />\n\t\t1 if daylight saving is on,<br />\n\t\t0 if off</li>\n";
	print "\t</ul>\n";
	print "\tSo, imitating the string variant may look something like this:<br />\n";
	printf("\t<tt>%s %s %d %02d:%02d:%02d %d (%d) (%s)</tt></li>\n",$weekdays[$wday],$months[$mon],$mday,$hour,$min,$sec,$the_year,$the_yearday,$isdst ? "DST is on" : "DST is off");
	print "</ol>\n";
    }
}

&cgi_head("time");
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
