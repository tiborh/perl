#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    my $webpage = "http://www.scriptsocket.com";
    print <<EOT;
<h1>Extracting links</h1>
<p>The links on <a href=\"$webpage\">$webpage</a>:</p>
EOT
    {
	use LWP::Simple;
	use HTML::LinkExtor;

	my $url = get($webpage);

	my $LinkExtor = HTML::LinkExtor->new(\&links);

	$LinkExtor->parse($url);

	sub links {
	    my ($tag, %links) = @_;
	    if ($tag eq "a") { #using img will help extract images
		foreach (keys %links) {
		    print "<p><a href=\"$links{$_}\">$links{$_}</a></p>\n" if ($_ eq "href");
		}
	    }
	}
    }
}

require "html.cgi";

&cgi_head("link extractor");
&main();
&printcode($0);
&cgi_foot();
exit;
