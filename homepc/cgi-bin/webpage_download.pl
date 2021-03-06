#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

sub main {
    print <<EOT;
<h1>Downloading a webpage</h1>
<ol>
  <li>The simplest way: <code>LWP::Simple</code></li>
  <li>Use the <code>get()</code> function of the module.</li>
  <li>Write the string variable into a file.</li>
</ol>
EOT
  {
      use LWP::Simple;
      
      my $uh = get("http://www.something.com/");
      my $fh;
      my $fn = "downloaded_webpage.html";
      open($fh,">",$fn) or die "Cannot open $fn, $!";
      print $fh $uh;
      close($fh);
      printcode($fn,"The content of the downloaded file");
  }
}

require "html.cgi";

&cgi_head("webpage download");
&main();
&printcode($0);
&cgi_foot();
exit;
