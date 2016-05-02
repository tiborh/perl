#!/usr/bin/perl -w
#use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Text file database";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Tied to an array.</p>
<p>Each line is a record</p>
<p>The array must exist before tie.</p>
EOT

use DB_File;
    use Fcntl;

    # read and write
    my $fn = 'dbfile.txt';
    my @array = ();
    tie(@array, "DB_File", $fn, O_RDWR|O_CREAT, 0644, $DB_RECNO) or die "Cannot open file $fn: $!\n";
    # append
    #tie(@array, "DB_File", 'dbfile.txt', O_APPEND, 0644, $DB_RECNO);

    #@array = qw(my text file database);

    print "<p>An item: $array[3]</p>\n";
    #$array[4] = "Simple!";
    #delete $array[1];
    print "<p>The whole array: @array</p>\n";

    untie @array;

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
