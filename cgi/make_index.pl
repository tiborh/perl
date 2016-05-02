#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
use File::Basename;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

print "Content-type:text/html\r\n\r\n";

print '<meta http-equiv="Content-Type" content="text/html" charset="utf-8" />',"\n";
print "<html>\n";
print "<head>\n";
print "\t<title>Files in cgi-bin</title>\n";
print "</head>\n";
print "<body>\n";
print "\t<h2>Files in cgi-bin</h2>\n";
print "\t<ul>\n";
while(<"/var/www/html/perl/*.html">)
{
    my $fn = basename($_);
    print("\t\t<li><a href='../perl/$fn'>$fn</a></li>\n");
}
print "\t</ul>\n";
print "</body>\n";
print "</html>\n";

