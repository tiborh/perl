#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "The Default Variable";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>\$\_ the most commonly used</p>
<p>can be used implicitly or explicitly, in various structures</p>
EOT

my @array = qw(一 二 三 四 五);

# implicit
    print "<pre>\n";
    $\="\n";
    print foreach (@array);
    $\="";
    print "</pre>\n";
# explicit
    print "<pre>\n";
    print "$_\n" foreach (@array);
    print "</pre>\n";

    @array = qw (one two three four five);

# with map or grep
    print "<pre>\n";
    $, = " ";
    print grep $_ =~ "o", (@array); print "\n";
    $, = "";
    print "</pre>\n";

# with stdin
    # print "input echo\n";
    # print while ($_ = <>);
    # print while (<>);

# substitute
    # print "input echo and substitution\n";
    # while (<>) {
    # 	s/a/o/gi;
    # 	print;
    # }

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
