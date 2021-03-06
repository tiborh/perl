#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Ref Operator";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Ref operator is used to determine what type of data the reference refers to.</p>
EOT

    {
	my $variable = "A variable.";
	my $reference = \$variable;
	printf("<p>Reference to a scalar variable: %s</p>\n",ref $reference);
    }
    {
	my %hash = qw(boat sea car road plane air);
	my $reference = \%hash;
	printf("<p>Reference to a hash variable: %s</p>\n",ref $reference);
    }
    {
	my $reference = \&printit;
	printf("<p>Reference to a subroutine: %s</p>\n",ref $reference);

	sub printit { print "A subroutine."; }
    }
    {
	my @numbers = (1..5);
	my $reference = \*numbers;
	printf("<p>Reference to a glob: %s</p>\n",ref $reference);
    }
    {
	my $fn = "ref_op.out";
	open(FILE,">",$fn) or die "Cannot open $fn, $!";
	my $reference = *FILE{IO};
	print $reference "An IO handle.\n";
	close($reference);
	printf("<p>Reference to a (IO) file handle: %s</p>\n",ref $reference);
    }
    {
	my $string = "A scalar of text.";
	my @string = qw(An array of text.);
	print <<EOT;
<p>A practical use: check the input in a subroutine.</p>
<p>First, a string reference is used as an input, then an array reference. The former is accepted, the latter is not.</p>
<p>Test string: $string</p>
EOT

print "<p>The two outputs:</p>\n";
	print "<ol>\n";
	print "\t<li>",doit(\$string),"</li>\n";
	print "\t<li>",doit(\@string),"</li>\n";
	print "</ol>\n";

sub doit{
    my $inref = shift;
    return uc($$inref) if (ref($inref) eq "SCALAR");
    return "Not a scalar!";
}

    }
}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;

    # SCALAR
    # ARRAY
    # HASH
    # CODE
    # REF
    # GLOB
    # LVALUE
    # FORMAT
    # IO
    # VSTRING
    # Regexp
