#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Closures";

sub main {
    my $preconfig_string = "Perl";
    my @test_strings = qw(tutorial script code);
    print <<EOT;
<h1>$title</h1>
<p>Closures make it possible to initialise subroutines with data before they are used.</p>
<p>They can only be used with lexical variables.</p>
<p>They are used in the following way:</p>
<ol>
  <li>A subroutine has the preconfigurable variables in its body.</li>
  <li>The non-configurable variables are in an unanimous subroutine inside the return statement of the subroutine.</li>
  <li>The subroutine is initialised by</li>
  <ul>
    <li>setting its configurable variables and</li>
    <li>binding the result to a reference</li>
  </ul>
<li>From then on, the reference is used to invoke the preconfigured subroutine.</li>
</ol>
<p>The subroutine of this example is pre-configured with the string \'$preconfig_string\' and then the reference is called (one by one) with the strings: @test_strings.</p>
EOT

    my $reference = printit($preconfig_string);
    &printthat($reference,\@test_strings);

    print "<p>By reinitialising the subroutine, we can easily replace the preconfigured string:</p>";

    $preconfig_string = "Python";
    $reference = printit($preconfig_string);
    &printthat($reference,\@test_strings);

sub printit {
    my $string1 = shift;
    return sub{
	my $string2 = shift;
	print "$string1 $string2\n";
    }
}

sub printthat {
    my $reference = $_[0];
    my @test_strings = @{$_[1]};
    print "<pre>\n";
    &$reference($_) foreach (@test_strings);
    print "</pre>\n";

}

}


require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
