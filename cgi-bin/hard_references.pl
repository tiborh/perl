#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Hard References";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Reference to the data item. Important to data structures.</p>
EOT

    my $reference;

    {
	my $variable = "A string of text.";
	$reference = \$variable;
	print "<p>Scalar reference: $reference</p>\n";
	print "<p>Derefernced: $$reference</p>\n";
    }

    {
	my @array = (1..10);
	$reference = \@array;
	print "<p>Array reference: $reference</p>\n";
	print "<p>Derefernced: @$reference</p>\n";
    }
    {
	my %hash = qw(
English Hello
French  Bonjour
);

	$reference = \%hash;
	print "<p>Hash reference: $reference</p>\n";
	print "<p>Derefernced (a key): $$reference{'English'}</p>\n";
    }
    {
	$reference = \&subroutine();
	print "<p>Subroutine reference: $reference</p>\n";
	print "<p>Running the subroutine (by dereferencing):<br />
(for some unknown reason, it usually prints two lines earlier than it should.)</p>\n";
	
	$$reference; 		# difficult to understand but it is printed earlier than issued.

	sub subroutine {
	    print "<p>I'm a subroutine!</p>\n";
	}
    }
}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
