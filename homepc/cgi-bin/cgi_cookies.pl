#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

use CGI;

#my %params = ();
my $cgi = new CGI;
my $Name = $cgi->cookie('name');
my $cookie = $cgi->cookie(
    -name=>'name',
    -value=>'Mark',
    -expires=>'+7d'
    );
print $cgi->header(
    -cookie=>$cookie
    ),
    $cgi->start_html(
    -title=>'CGI.pm Cookies'
    );

print "<p>";
unless ($Name) {print "Cookie has been set.";} else {print "Hi $Name!";}
print "</p>\n";

print $cgi->end_html,"\n";

exit;
