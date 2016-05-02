#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

use CGI;

my $cgi = new CGI;
print $cgi->header,
    $cgi->start_html(
	-title=>'CGI.pm Forms process'
    );


# results
print "<p>\n";
my %params = $cgi->Vars();
print "$_: $params{$_}<br />\n" foreach (keys %params);
# print "Textbox: ", $cgi->param('textbox'), $cgi->br, "\n" if ($cgi-param('textbox'));
# print "Password: ", $cgi->param('password'), $cgi->br, "\n" if ($cgi-param('password'));
# print "Radio: ", $cgi->param('radio'), $cgi->br, "\n" if ($cgi-param('radio'));
# print "Checkboxes: ", $cgi->param('checkboxes'), $cgi->br, "\n" if ($cgi-param('checkboxes'));
# print "Scrollbox: ", $cgi->param('scrollbox'), $cgi->br, "\n" if ($cgi-param('scrollbox'));
# print "Textarea: ", $cgi->param('textarea'), $cgi->br, "\n" if ($cgi-param('textarea'));
# print "Hidden: ", $cgi->param('hidden'), $cgi->br, "\n" if ($cgi-param('hidden'));
print "</p>\n";

print $cgi->end_html,"\n";
