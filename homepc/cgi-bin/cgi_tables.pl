#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

use CGI;

my $cgi = new CGI;
print $cgi->header,
    $cgi->start_html(
	-title=>'CGI.pm Tables'
    ),
    $cgi->start_table({-width=>'400',
		      -border=>'1'}), "\n",
    $cgi->start_Tr, "\n",
    $cgi->start_td({-width=>'200',
		   -align=>'center'}),
    "Cell 1",
    $cgi->end_td, "\n",
    $cgi->start_td({-width=>'200',
		   -align=>'center'}),
    "Cell 2",
    $cgi->end_td, "\n",
    $cgi->end_Tr, "\n",
    $cgi->start_Tr, "\n",
    $cgi->start_td({-colspan=>'2',
		    -align=>'center',
		   -bgcolor=>'red'}),
    "Cell 3",
    $cgi->end_td, "\n",
    $cgi->end_Tr, "\n",
    $cgi->end_table, "\n",
    $cgi->end_html;

exit;
