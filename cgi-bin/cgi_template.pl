#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

use CGI;

#my %params = (); #later this can be made equal to %{$cgi->Vars()}
my $cgi = new CGI;
print $cgi->header,
    $cgi->start_html(
	-title=>'CGI.pm '
    ),


$cgi->end_html,"\n";

exit;
