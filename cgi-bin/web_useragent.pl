#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    print <<EOT;
<h1>Emulating a user agent (browser)</h1>
<p><code>LWP::UserAgent</code> can be used for browser emulation. It can sent HTTP requests and receive the response into a hash reference, which can be parsed in the same way as shown in <a href="webpage_parser.pl">webpage_parser.pl</a>.</p>
EOT
    {
	use LWP::UserAgent;
	my $UserAgent = new LWP::UserAgent;

	my $Request = new HTTP::Request('get','http://www.scriptsocket.com/');

	my $Response = $UserAgent->request($Request);
#reference to a hash
	
	my $fh;
	my $fn = "web_useragent_output.html";
	open($fh,">",$fn) or die "Cannot open $fn, $!";
	print $fh $Response->{_content};
	close($fh);
	print "<p>The output has been written to <a href=\"$fn\">$fn</a>.</p>\n";
    }

}

require "html.cgi";

&cgi_head("template");
&main();
&printcode($0);
&cgi_foot();
exit;
