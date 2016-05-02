#!/usr/bin/perl -w

use String::Scanf; #String-Scanf-2.1 from http://search.cpan.org

$a=$b=0;
$inline="";

print "Two numbers: ";
$inline=<STDIN>;
($a, $b)=sscanf("%d %d",$inline);

print "a = $a\n";
print "b = $b\n";

#end of read_stdin.pl
