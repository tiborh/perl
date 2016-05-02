#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Formats - Low-level Formatting";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>A short intro into low-level formatting.</p>
EOT

formline <<'EOF', "left", "center", "right";
@<<<<<<<<@||||||||@>>>>>>>>
EOF

print "<pre>\n";
print "$^A";			# format accummulator
    $^A = "";

formline <<'EOF', "left", "center", "right";
@<<<<<<<<@||||||||@>>>>>>>>
EOF

print "$^A";
    $^A = "";
print "</pre>\n";

}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
