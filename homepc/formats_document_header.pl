#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Formats - Create Document Header";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Creating a document header.</p>
EOT


format myformat_top = 
@||||||||||||||||||||||||||||||
"Members of Staff"
First   Last    ID      Phone
-------------------------------
.

    my @FN = qw(John Fred Sarah Ray);
    my @LN = qw(Smith Jones Thomas Biggs);
    my @ID = qw(652 781 167 442);
    my @PH = qw(x23 x54 x7 x18);
    my $c=0;
    my $fn = "formats_document_header.txt";
    my $fh;
    my $myformat_top = "myformat_top";
    my $myformat = "myformat";

format myformat = 
@<<<<<<<@<<<<<<<@<<<<<<<@<<<<<<<
$FN[$c],$LN[$c],$ID[$c],$PH[$c] 
.
open($fh,">",$fn) or die "Cannot open $fn, $!";
select $fh;
$~ = $myformat;
$^ = $myformat_top;
while ($c <= $#FN) {
write;
$c++;
}
select STDOUT;
close $fh;
print "<p>Data has been written to $fn.</p>\n";
}

&main();

exit;
