#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

use CGI;

#my %params = (); #later this can be made equal to %{$cgi->Vars()}
my $cgi = new CGI;
print $cgi->redirect('http://www.harcsa.net/');
print $cgi->start_html(), $cgi->end_html,"\n";

exit;
