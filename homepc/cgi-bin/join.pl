#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>The join function</h1>\n";
	{
	    print "<h2>Joining strings</h2>\n";
	    print "<p>The strings to be joined:</p>\n";
	    my ($w0,$w1,$w2,$w3,$w4) = qw(蟹 蝸牛 猿 蛇 猫);
	    my $平仮名_string = "かに、かたつむり、さる、へび、ねこ";
	    print "<ol>\n";
	    print "\t<li>$_</li>\n" foreach ($w0,$w1,$w2,$w3,$w4);
	    print "</ol>\n";
	    my $joined_string = join("、",$w0,$w1,$w2,$w3,$w4);
	    print "<p>The string after join:<br />\n";
	    print "<div style='font-size: 200%'>$joined_string</div><br />\n";
	    print "($平仮名_string)</p>\n";
	}
	{
	    print "<h2>Joining strings from an array</h2>\n";
	    print "<p>The strings to be joined:</p>\n";
	    my @the_strings = qw(或る日 、 彼 は 弱い 亀 を 助け た 。);
	    my $平仮名_string = "あるひ、かれは｜よわい｜かめを｜たすけた。";
	    print "<ol>\n";
	    print "\t<li>$_</li>\n" foreach (@the_strings);
	    print "</ol>\n";
	    my $joined_string = join("",@the_strings);
	    print "<p>The string after join:<br />\n";
	    print "$joined_string<br />\n";
	    print "($平仮名_string)</p>\n";
	}
    }
}

&cgi_head("Functions: join");
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
