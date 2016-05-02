#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "References to typeglobs";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>These are useful when the referenced data does not have a specific data type, such as a filehandle.</p>
<p>As an example, 1. create a subroutine, 2. open a file, 3. pass its handle to the subroutine. 4. Close the file.</p>
EOT

sub printit {
    my $handle = shift;
    print $handle "A file reference.\n";
    print "<p>Passed file handle printed out in the subroutine: $handle</p>\n";
}

# passing a filehandle to a sub
open(FILE, ">", "file.txt");
printit(\*FILE);
close(FILE);

# lvalue reference:
my $reference = \substr("An lvalue reference",3,6);
print "<p>Printing out lvalue reference: $reference</p>\n";
print "<p>Printing out dereferenced lvalue reference: $$reference</p>\n";

# code reference
$reference = sub {
    print "Some code reference.";
};
print "<p>Printing out anonymous subroutine by reference:<br />\n";
&$reference;
print "</p>\n";
print "<p>Printing out subroutine reference: $reference</p>\n";

}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
