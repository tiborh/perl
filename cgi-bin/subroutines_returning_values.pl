#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Subroutines - Returning Values";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>The last evaluated value of a subroutine is returned.</p>
<p>Explicit <code>return</code> can also be used.</p>
<p>The return value can be:</p>
<ul>
  <li>a scalar</li>
  <li>a list</li>
  <li>a hash</li>
</ul>
EOT

print "<p>Reference is returned: ",&tryit("something"),"</p>\n";
print "<p>Dereferencing the returned item: ",${&tryit("something")},"</p>\n";

sub tryit($) {
    my $variable = shift;
    return \$variable;
}

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
