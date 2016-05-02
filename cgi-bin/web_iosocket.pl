#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

# this one does not work: Unsupported

sub main {
    print <<EOT;
<h1>Downloading a web page with IO::Socket</h1>
<p></p>
EOT
    {
	use IO::Socket;
	my $Socket = IO::Socket::INET-> new(
	    Proto    => "tcp",
	    #PeerAddr => "www.berm.co.nz",
	    PeerAddr => "www.harcsa.net",
	    PeerPort => 80
	    );

	$Socket->autoflush(1);

	print $Socket "get /index.html HTTP/1.0\015\012\015\012";
	#print $Socket "get /video/index.php HTTP/1.0\015\012\015\012";
        #new line characters at the end

	my $fh;
	my $fn = "web_iosocket_output.txt";
	open($fh,">",$fn) or die "Cannot open $fn, $!";
	while (<$Socket>) {
	    print $fh $_;
	}
	close($fh);
	close $Socket;
	printcode($fn,"The output of the download");
    }
}

require "html.cgi";

&cgi_head("IO::Socket");
&main();
&printcode($0);
&cgi_foot();
exit;
