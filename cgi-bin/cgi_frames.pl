#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

use CGI;

my %params = ();
my $cgi = new CGI;
print $cgi->header,

    $cgi->frameset(
	{-rows=>'40%,60%'},"\n",
	$cgi->frame({-name=>'top',
		    -src=>'http://dotcodotnz.co.nz/'}), "\n",
	$cgi->frame({-name=>'bottom',
		    -src=>'http://scriptsocket.com/'}), "\n",
    );

exit;
