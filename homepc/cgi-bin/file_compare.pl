#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "File Compare";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>The <code>File::Compare</code> is used to compare two files.</p>
EOT

   {
       my $file1 = 'a.txt';
       my $file2 = 'b.txt';
       my $file3 = 'c.txt';
       my $file0 = 'd.txt';

       &comparator($file1,$file2);
       &comparator($file1,$file3);
       &comparator($file1,$file1);
       &comparator($file1,$file0);

       sub comparator {
	   use File::Compare;
	   my $file1 = $_[0];
	   my $file2 = $_[1];
	   my $compare = compare($file1,$file2);
	   print "<p>Comparing <code>$file1</code> and <code>$file2</code>: ";
	   if ($compare == -1) {
	       print "an error has occurred.</p>\n";
	   } else {
	       print "they are ", $compare ? "different" : "the same", ".</p>\n";
	   }
	   
       }
   }

}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
