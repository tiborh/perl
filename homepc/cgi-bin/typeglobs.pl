#!/usr/bin/perl -w
#use strict; #does not work with aliases
use utf8;
binmode STDOUT, ":utf8";

my $title = "Typeglobs";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>They are like aliases and we can tie a variable to a new variable name with their help. Like a wildcard.</p>
<p>Typeglobs can also be used with filehandlers. (not covered here)</p>
<p><b>Note:</b> it does not work with \"strict\" pragma and \"my\" (lexical) variables.</p>
EOT

    $data = "A variabla of data.";
    @data = qw(an array of data);
    %data = qw(
big dog
small cat
tiny mouse
);
sub data {
    print "A subroutine of data.\n";
}
# setting up an alias
*aliasdata = *data;

print "<p>Used as a variable: $aliasdata</p>\n";
print "<p>Used as an array: @aliasdata</p>\n";
print "<p>Used as a hash (with a key): $aliasdata{'big'}</p>\n";
print "<p>Used as a subroutine:<br />\n";
&aliasdata;
print "</p>\n";

# if only one is aliased:
*aliasdata = \$data;
print "<p>Now only the variable: $aliasdata</p>\n";

}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
