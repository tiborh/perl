#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>The usage of substr</h1>\n";
	my $a_string = "If a dog jumps in your lap, it is because he is fond of you; but if a cat does the same thing, it is because your lap is warmer.";
	print "<p>The sample string we are going to work with:<br />\n";
	print "<i>$a_string</i></p>\n";
	{
	    print "<ol>\n";
	    print "\t<li>Using two variables: 1. string 2. an index:<br />\n";
	    my $first_because = index($a_string,"because");
	    my $last_because = rindex($a_string,"because");
	    my $rt_string = substr($a_string,$first_because);
	    print "\tthe returned string: <i>$rt_string</i><br />\n";
	    print "\tthe string (unchanged):<br /><i>$a_string</i><br />\n";
	    print "\tor (using <tt>rindex()</tt>)<br />\n";
	    $rt_string = substr($a_string,$last_because);
	    print "\tthe returned string: <i>$rt_string</i></li>\n";
	    print "\t<li>Using three variables: 3. how long?:<br />\n";
	    $rt_string = substr($a_string,$first_because,index($a_string,";")-$first_because);
	    print "\tthe returned string: <i>$rt_string</i><br />\n";
	    print "\tthe string (unchanged):<br /><i>$a_string</i></li>\n";
	    print "\t<li>Using four variables: 4. replacement string:<br />\n";
	    $rt_string = substr($a_string,$first_because,index($a_string,";")-$first_because,"because he is a fool");
	    print "\tthe returned string: <i>$rt_string</i><br />\n";
	    print "\tthe string (changed):<br /><i>$a_string</i><br />\n";
	    print "\tor<br />\n";
	    $last_because = rindex($a_string,"because"); # length changed because of previous replacement
	    $rt_string = substr($a_string,$last_because,index($a_string,".")-$last_because,"because either it offers her an advantage or she wants something");
	    print "\tthe returned string: <i>$rt_string</i><br />\n";
	    print "\tthe string (changed):<br /><i>$a_string</i></li>\n";
	    print "</ol>\n";
	    print "<p><b>Note:</b> This script also shows examples for the usage of <tt>index()</tt> and <tt>rindex()</tt>.";
	}
    }
}

&cgi_head("Functions: substr");
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
