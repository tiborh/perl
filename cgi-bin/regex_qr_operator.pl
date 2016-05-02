#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Regex - qr operator";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>perl allows the interpolation of variables into regular expressions</p>
<p>with the qr operator, perl can optimise the bit code</p>
EOT

# my $regex = '\bhello\b';
#     my $string = "I say hello.";
#     print "$string\n";
#     $string =~ s/$regex/goodbye/;
#     print "$string\n";


# $regex = qr/\bhello\b/;
#     $string = "I say hello.";
#     print "$string\n";
#     $string =~ s/$regex/goodbye/;
#     print "$string\n";

# my @patterns = (
#     qr/\bred\b/,
#     qr/\bgreen\b/,
#     qr/\bblue\b/,
#     qr/\byellow\b/,
#     qr/\borange\b/,
#     );

#     while (<>) {
# 	foreach (my $c=0; $c <= $#patterns; $c++) {
# 	    print /$patterns[$c]/ ? "Matched pattern $patterns[$c]\n" : "Pattern did not match.\n";
# 	}
#     }

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
