#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

use CGI;

my %params = ();
my $cgi = new CGI;
print $cgi->header,
    $cgi->start_html(
	-title=>'CGI.pm Forms'
    ),

    $cgi->start_form(
	-method=>'post',
	-action=>''),"\n", 	# self-processing if left empty
    "Textbox: ",
    $cgi->textfield(-name=>'10_textbox',-size=>15), $cgi->br,$cgi->br, "\n",
    "Password: ",
    $cgi->password_field(-name=>'20_password',-size=>15), $cgi->br,$cgi->br, "\n",
    "Radio: ",
    $cgi->radio_group(
	-name=>'30_radio',
	-values=>['Red','Blue','Green'],
	-default=>'Blue'
    ),$cgi->br,$cgi->br,"\n",
    "Checkboxes: ",
    $cgi->checkbox_group(
	-name=>'40_checkboxes',
	-values=>['Burger','Fries','Coke'],
	-defaults=>['Coke']
    ),$cgi->br,$cgi->br,"\n",
    "Scrollbox: ",
    $cgi->scrolling_list(
	-name=>'50_scrollbox',
	-size=>1,
	-values=>['Hat','Coat','Jacket'],
	-defaults=>['Jacket']
    ),$cgi->br,$cgi->br,"\n",
    "Comments: ",
    $cgi->textarea(
	-name=>'60_textarea',
	-columns=>20,
	-rows=>5
    ),$cgi->br,$cgi->br,"\n",
    $cgi->hidden(-name=>'70_hidden',-value=>'Toys'), "\n",
    $cgi->submit(-value=>'Submit'), "\n",
    $cgi->reset, "\n",
    $cgi->end_form;

%params = $cgi->Vars();
print "<p>\n";
print "$_: $params{$_}<br />\n" foreach (sort keys %params);
print "</p>\n";
print $cgi->end_html,"\n";

exit;
