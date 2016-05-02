#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>The splice function</h1>\n";
	my @an_array = qw(月曜日 火曜日 水曜日 木曜日 金曜日 土曜日 日曜日);
	my @cp_array = @an_array;
	my @rt_array = ();
	print "<p>The starting array:";
	print "<br />\n$_: $an_array[$_]" foreach (0..$#an_array);
	print "</p>\n";
	{
	    print "<h2>Explanation</h2>\n";
	    print "<ol>\n";
	    print "\t<li>Using two variables: 1. string 2. an index:<br />\n";
	    @rt_array = splice(@cp_array,5);
	    print "\tThe returned array: (@rt_array).<br />\n";
	    print "\tThe array: (@cp_array).</li>\n";
	    @cp_array = @an_array;
	    print "\t<li>Using three variables: 3. length:<br />\n";
	    @rt_array = splice(@cp_array,4,2);
	    print "\tThe returned array: (@rt_array).<br />\n";
	    print "\tThe array: (@cp_array).</li>\n";
	    @cp_array = @an_array;
	    print "\t<li>Using four variables: 4. replacement item or list:<br />\n";
	    @rt_array = splice(@cp_array,5,2,"土日");
	    print "\tThe returned array: (@rt_array).<br />\n";
	    print "\tThe array: (@cp_array),<br />\n\tor<br />\n";
	    @rt_array = splice(@cp_array,5,1,"Saturday","Sunday");
	    print "\tThe returned array: (@rt_array).<br />\n";
	    print "\tThe array: (@cp_array)</li>\n";
	    print "</ol>\n";
	}
	{
	    print "<h2>Using splice instead of other array functions</h2>\n";
	    print "<ol>\n";
	    @cp_array = @an_array;
	    my $returned_item = "";
	    print "\t<li>for pop:<br />\n";
	    $returned_item = splice(@cp_array,-1); # ,1 at the end can be omitted
	    print "\tThe returned item: $returned_item.<br />\n";
	    print "\tThe array: (@cp_array).</li>\n";
	    print "\t<li>for push:<br />\n";
	    splice(@cp_array,@cp_array,0,"Sunday");
	    print "\tThe array: (@cp_array).</li>\n";
	    print "\t<li>for shift:<br />\n";
	    $returned_item = splice(@cp_array,0,1);
	    print "\tThe returned item: $returned_item.<br />\n";
	    print "\tThe array: (@cp_array)</li>\n";
	    print "\t<li>for unshift:<br />\n";
	    splice(@cp_array,0,0,"Monday");
	    print "\tThe array: (@cp_array)</li>\n";
	    print "</ol>\n";
	}
    }
}

&cgi_head("Functions: splice");
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
