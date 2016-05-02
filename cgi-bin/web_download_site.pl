#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    print <<EOT;
<h1>Downloading site</h1>
<p></p>
EOT
     {
	 use LWP::Simple;
	 require HTML::Parser;
	 require HTML::LinkExtor;

	 our $Domain = "ageofempires.co.nz";
	 my $URL = get("http://www.ageofempires.co.nz");
	 mkdir "$Domain";
	 my $LinkExtor = HTML::LinkExtor->new(\&links);

	 $LinkExtor->parse($URL);
	 sub links {
	     my ($tag, %links) = @_;
	     if ($tag = "a href" && defined($links{href}) && $links{href} =~ "$Domain") {
		 my $url = $links{href};
		 my $file = $url;
		 $file =~ s/http:\/\/www\.//;
		 $file =~ s/http:\/\///g;
		 $file =~ tr/\//-/;
		 mirror($url, "$Domain/$file.html");
		 print "<p>Making $file.html</p>\n";
	     }
	 }
	 my $url = "http://$Domain";
	 my $file = $url;
	 $file =~ s/http:\/\/www\.//;
	 $file =~ s/http:\/\///;
	 $file =~ tr/\//-/;
	 mirror($url, "$Domain/$file.html");
	 print "Making $file.html\n";
     }
}

require "html.cgi";

&cgi_head("template");
&main();
&printcode($0);
&cgi_foot();
exit;
