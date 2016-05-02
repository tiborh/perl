#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    my $webpage = "http://www.scriptsocket.com";
    print <<EOT;
<h1>Parsing the head of a webpage</h1>
<p>Extracting <code>&lt;head></code> information</p>
EOT
    {
	use LWP::Simple;
	use HTML::HeadParser;

	my $url = get($webpage);
	my $hhead = HTML::HeadParser->new;
	$hhead->parse("$url");

	print "<p><b>Title</b>:</b> " . $hhead->header('Title') . "</p>\n\n";
	print "<p><b>X-Meta-Description</b>: " . $hhead->header('X-Meta-Description') . "</p>\n";
	print "<p><b>X-Meta-Keywords</b>: " . $hhead->header('X-Meta-Keywords') . "</p>\n";
	print "<p><b>X-Meta-Robots</b>: " . $hhead->header('X-Meta-Robots') . "</p>\n";
	print "<p><b>X-Meta-Revisit-After</b>: " . $hhead->header('X-Meta-Revisit-After') . "</p>\n";
	print "<p><b>Content-Type</b>: " . $hhead->header('Content-Type') . "</p>\n";
	print "<p><b>Content-Language</b>: " . $hhead->header('Content-Language') . "</p>\n";
	print "<p><b>Content-Base</b>: " . (defined($hhead->header('Content-Base')) ? $hhead->header('Content-Base') : "undef") . "</p>\n";
    }
}

require "html.cgi";

&cgi_head("head parser");
&main();
&printcode($0);
&cgi_foot();
exit;
