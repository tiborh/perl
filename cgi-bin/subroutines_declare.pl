#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Declaring Subroutines";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Subroutines are declared similarly to C. e.g.: sub addit;</p>
<p>After a subroutine is declared the & symbol can be omitted before it (or the parentheses after it) when it is called.</p>
EOT

sub doit;

doit;

sub doit{
    print "<p>I'm a subroutine.</p>\n";
}

sub addit;

my ($num1,$num2) = (5,5);
print "<p>Sum of $num1 and $num2: ",(addit $num1,$num2),"</p>\n";

sub addit{
    my ($num1, $num2) = @_;
    $num1 + $num2;
}

} # main 

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
