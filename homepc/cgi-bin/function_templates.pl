#!/usr/bin/perl -w
#use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Function Templates";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Function templates are created using <a href="closures.pl">closures</a></p>
EOT

my @vehicles = qw(Car Bus Bike Train);

    print "<p>The not proper one uses a normal reference.</p>\n";
# not a proper one:
    foreach my $item (@vehicles) {
	${"print" . $item} = sub {print "$item\n"};
    }

    print "<pre>\n";
    &$printCar();
    &$printTrain();
    print "</pre>\n";

    print "<p>The proper one uses a glob reference.</p>\n";
# the proper way:
    foreach my $item (@vehicles) {
	*{"print" . $item} = sub {print "$item\n"};
    }

    print "<pre>\n";
    &printCar();
    &printTrain();
    print "</pre>\n";
}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
