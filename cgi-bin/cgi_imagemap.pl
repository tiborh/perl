#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

use CGI;

my %params = ();
my $cgi = new CGI;
my $JSCRIPT=<<EOF;
function openWindow(){
    window.open("http://www.beatles.com","mywindow","width=400, height=250, left=10, top=500");
}
EOF

print $cgi->header,
    $cgi->start_html(
	-title=>'CGI.pm Image Map',
	-script=>$JSCRIPT
    ),

$cgi->start_form,
$cgi->image_button(
    -name=>'beatles',
    -src=>'http://localhost/~tibor/img/beatles.jpg',
    -width=>360,
    -height=>99,
    -onClick=>"openWindow()"
    ),
    $cgi->end_form;

my $x;
my $y;
my $Who;
%params = %{$cgi->Vars()};

if (%params) {
    $x = $params{'beatles.x'};
    $y = $params{'beatles.y'};
    print "<p>params:</p>\n"; 
    print "<p>$_: $params{$_}</p>\n" foreach (keys %params);
    $Who = 'John' if ($x <= 90);
    $Who = 'Paul' if ($x >= 91 && $x <= 180);
    $Who = 'George' if ($x >= 181 && $x <= 270);
    $Who = 'Ringo' if ($x >= 271 && $x <= 360);
    print "<p><b>You clicked $Who at coordinates Left=$x, Top=$y</b></p>\n";
}


print $cgi->end_html,"\n";

exit;
