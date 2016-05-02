#!/usr/bin/perl

use warnings;
use strict;

use POSIX qw(strftime);
use Time::Piece;

my $inseconds = time();
my $timenow = localtime($inseconds);
my $expiry_time = localtime($inseconds + 3600);
my $t = $expiry_time;
my $tzone = strftime("%Z",localtime);
my $expiry_time2 = sprintf("%s, %s %s %s",$t->fullday,$t->ymd,$t->hms,$tzone); 
# e.g. Tuesday, 31-Dec-2007 23:12:40 GMT

print "Set-Cookie:UserID=XYZ;\n";
print "Set-Cookie:Password=XYZ123;\n";
print "Set-Cookie:Expires=$expiry_time;\n";
print "Set-Cookie:Domain=localhost;\n";
print "Set-Cookie:Path=/perl;\n";
print "Content-type:text/html\r\n\r\n";

print '<meta http-equiv="Content-Type" content="text/html" charset="utf-8" />';
print "<html>\n";
print "<head>\n";
print "\t<title>Cookies</title>\n";
print "</head>\n";
print "<body>\n";
print "\t<h2>Cookie timeout has been set to $expiry_time2</h2>\n";
print "</body>\n";
print "</html>\n";
