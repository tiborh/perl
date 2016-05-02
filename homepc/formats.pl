#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Using Formats";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>This script explores the usage of text formats.</p>
EOT

    my $a = "a";
    my $b = "b";
    my $c = "c";
    my $d = "d";
    my $number = rand(100);
    my $myformat = "myformat";
    format myformat = 
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
@#.##
$number
#as is
@*
"Words
   as
   they
appear."
.
#write;
my $fh;
my $fn = "file.txt";
open $fh,">",$fn;
select $fh;
$~ = $myformat;
write;
close($fh);
select STDOUT;
print "<p>The formatted output has been written to $fn</p>\n";
}


&main();
exit;
