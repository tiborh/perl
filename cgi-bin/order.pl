#!/usr/bin/perl -w

use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    {
	print "<h1>Order Confirmation</h1>\n";
	my %FORM = ();

	read(STDIN, my $buffer, $ENV{'CONTENT_LENGTH'});
	my @pairs = split(/&/, $buffer);
	foreach my $pair (@pairs) {
	    my ($name, $value) = split(/=/, $pair);
	    $value =~ tr/+/ /;
	    $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
	    $FORM{$name} = $value;
	}

	my $Name = exists($FORM{'name'}) ? $FORM{'name'} : "no name";
	my $Burger = exists($FORM{'burger'}) ? $FORM{'burger'} : "no";
	my $Fries = exists($FORM{''}) ? $FORM{''} : "no";
	my $Coke = exists($FORM{'coke'}) ? $FORM{'coke'} : "no";
	my $Coffee = exists($FORM{'coffee'}) ? $FORM{'coffee'} : "no";
	my $Tea = exists($FORM{'tea'}) ? $FORM{'tea'} : "no";

	my $Payment = exists($FORM{'payment'}) ? $FORM{'payment'} : "not selected";

	my $FirstTime = exists($FORM{'firsttime'}) ? $FORM{'firsttime'} : "not selected";
	my $Comments = exists($FORM{'comments'}) ? $FORM{'comments'} : "no comment";

	my $Store = exists($FORM{'store'}) ? $FORM{'store'} : "no store info";

	print <<EOF;
<pre>
Thank you $Name!
Here is your order.

Burger: $Burger
Fries: $Fries
Coke: $Coke
Coffee: $Coffee
Tea: $Tea

Payment: $Payment

First Time Customer: $FirstTime
Comments: $Comments

$Store
</pre>
EOF
print "<p>The buffer<br />\n$buffer</p>\n";
    }
}

# source http://www.scriptsocket.com/code.php
# read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
# @pairs = split(/&/, $buffer);
# foreach $pair (@pairs) {
#     ($name, $value) = split(/=/, $pair);
#     $value =~ tr/+/ /;
#     $value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
#     $FORM{$name} = $value;
# }

require "html.cgi";

&cgi_head("order confirmation");
&main();
&printcode($0);
&cgi_foot();
exit;
