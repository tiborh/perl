#!/usr/bin/perl -w
#use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Database - Sort";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>DB_File and Fcntl modules are used. See the source code below for comments.</p>
<p>The array must exist before tie.</p>
EOT
use DB_File;
    use Fcntl;

    my %hash = ();
    # the compare algorithm
    $DB_BTREE->{'compare'} = sub {
	shift cmp shift;
    };

    # write
    #tie(%hash, "DB_File", 'sorted', O_RDWR|O_CREAT|O_TRUNC, 0644, $DB_BTREE);
    # read only
     tie(%hash, "DB_File", 'sorted', O_RDONLY, 0644, $DB_BTREE);
    # append (together with write)
    # tie(%hash, "DB_File", 'sorted', O_APPEND, 0644, $DB_BTREE);

# %hash = qw(
# Lennon McCartney
# Page Plant
# Jagger Richards
# Mann Weil
# Goffin King
# Rodgers Hart
# Bacharach David
# Leiber Stoller
# Gershwin Gershwin
# John Taupin
# );


    #$hash{'Davies'} = "Hodgson";
    print "<pre>\n";
    while(my ($key, $value) = each(%hash)) {
	print "$key - $value\n";
    }
    print "</pre>\n";
    untie %hash;

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
