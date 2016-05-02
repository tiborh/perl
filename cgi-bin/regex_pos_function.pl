#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "The pos function and the capital G assertion";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>pos(): the position of the last finds of in the specified or default variable</p>
<p>\\G assertion: starts pattern match where the last global pattern match stopped</p>
EOT

my $string = "Monday Tuesday Wednesday Thursday Friday";
    print "<p>The original string:<br/>\n$string</p>\n";

    print "<p>capital T location";
    while ($string =~ m/T/g) {
	my $position = pos($string);
	print "<br />\nThe position after match: $position";
    }
    print "</p>\n";

    # capital letter positions
    print "<p>capital letter location";
    while ($string =~ m/[A-Z]/g) {
	my $position = pos($string);
	print "<br />\nThe position after match: $position";
    }
    print "</p>\n";

    # white space positions
    print "<p>white space location";
    while ($string =~ m/[\s]/g) {
	my $position = pos($string);
	print "<br />\nThe position after match: $position";
    }
    print "</p>\n";

    $_ = "Cars Trucks Boats Trailers Planes Trains Bicycles";
    print "<p>The original string:<br/>\n$_<br />\n";

    m/T/g;
    my $position = pos();
    print "from position $position: ";
    m/\G(.*)/g;
    print "$1<br />\n";

    $_ = $1;
    m/T/g;
    my $position = pos();
    print "from position $position: ";
    m/\G(.*)/g;
    print "$1<br />\n";

    $_ = $1;
    m/T/g;
    my $position = pos();
    print "from position $position: ";
    m/\G(.*)/g;
    print "$1</p>\n";

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
