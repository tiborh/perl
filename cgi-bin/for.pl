#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "For Loop";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>For loops can be used in the classical (C-style) way and in scripting style.</p>
<p>They are commonly used for looping thru arrays.</p>
<p>Hashes can also be looped thru with them, but then every item is listed one by one, not distinguising between keys and values.</p>
<p>They are often used instead of foreach as a shorthand.</p>
EOT

# the classical (C) way:
# for (
#     my $loop_index;		# before execution
#     $loop_index <= 10;		# to be tested before each loop until true
#     $loop_index++;		# executed after every loop run
# )
# {
#     print "block of code comes here\n";
# }

# the scripting way:
# my @array = qw(car bus tram trolley metro);
#     print "$_\n" for (@array);

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
