#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

use CGI;

my $cgi = new CGI;
print $cgi->header,
    $cgi->start_html(
	-title=>'My Web Page',
	-meta=>{'keywords'=>'kw1,kw2',
	'description'=>'My description'},
	-bgcolor=>'lightblue',
	-vlink=>'orange'
    ),
    $cgi->center($cgi->h1('My Page Header')),"\n",
    $cgi->p("A line of text."),"\n",
    $cgi->img({-src=>'http://localhost/~tibor/img/fish.png',-alt=>'A fish'}),
    $cgi->br,"\n",
    $cgi->a({-href=>'http://www.scriptsocket.com/',-target=>'_blank'},"ScriptSocket.com"),
    $cgi->end_html;

exit;
