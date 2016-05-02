#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Subroutines - Reading Arguments";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Arguments passed to a subroutine are stored in a special variable: \@_.</p>
<p>Its elements can be accessed in various ways.</p>
<ul>
  <li>one by one (\$_[0]),</li>
  <li>with <code>shift</code>,</li>
  <li>via list assignment ( (\$var1, \$var2) = \@_ ),</li>
  <li>in a <code>foreach</code> loop</li>
</ul>
EOT



} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
