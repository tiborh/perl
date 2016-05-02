#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Formats";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Testing Perl\'s test formatting capabilities.</p>
<p>For further reference, have a look into <a href=\'http://perldoc.perl.org/perlform.html\'>Perldoc, Perlform</a></p>
EOT
    my $a = "a";
    my $b = "b";
    my $c = "c";
    my $d = "d";
    my $number = rand(100);
    print "<pre>\n";
    format = 
# left
@<<<<<<<@<<<<<<<@<<<<<<<@<<<<<<<
$a,     $b,     $c,     $d

# right
@>>>>>>>@>>>>>>>@>>>>>>>@>>>>>>>
$a,     $b,     $c,     $d
# center
@|||||||||||||||||||||||||||||||
"In the Center"
# mixed
@>>>>>>>@<<<<<<<@|||||||@>>>>>>>
$a,     $b,     $c,     $d
# number
@>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
$number
@#.##
$number
#as is
@*
"Words
   as
   they
appear."
.
write;
    print "</pre>\n";
}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
