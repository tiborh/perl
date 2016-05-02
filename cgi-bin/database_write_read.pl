#!/usr/bin/perl -w
#use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Database - Write and Read";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>Several file-database modules exist. <code>SDBM_File</code> is sure to be included in any Perl installations.</p>
<p>Before db operations, the hash is tied to it, and after the operation, it is untied from it.</p>
<p>The <code>Fcntl</code> module is used for file operation symbolic constants.</p>
<p>Various types of db operations:</p>
<dl>
<dt>write</dt>
  <dd>tie \%hash, \"SDBM_File\", \'data\', O_RDWR|O_CREAT|O_EXCL, 0644;</dd>
<dt>read</dt>
  <dd>tie \%hash, \"SDBM_File\", \'data\', O_RDWR, 0644;</dd>
<dt>append</dt>
  <dd><dd>tie \%hash, \"SDBM_File\", \'data\', O_APPEND, 0644; \#together with \'read\'</dd></dd>
<dt>truncate</dt>
  <dd>tie \%hash, \"SDBM_File\", \'data\', O_WRONLY|O_TRUNC, 0644; \#together with \'read\' (make empty)</dd>
</dl>
EOT

use Fcntl; # file handling symbolic constants
use SDBM_File; #others ODBM, NDBM, GDBM

    my %hash = ();

# 1. tie to a database
    # write
#    tie %hash, "SDBM_File", 'data', O_RDWR|O_CREAT|O_EXCL, 0644;

    # append (together with "read")
    # tie %hash, "SDBM_File", 'data', O_APPEND, 0644;

    # truncate: empty out (together with "read")
    #tie %hash, "SDBM_File", 'data', O_WRONLY|O_TRUNC, 0644;

    # read
    tie %hash, "SDBM_File", 'data', O_RDWR, 0644;

#once written into the db, these are not needed.
#%hash = qw(
#hello Goodbye
#Hola Adios
#);

    #when appending (together with read)
    #$hash{'Bonjour'} = "Au revoir";

    while (my ($key, $value) = each(%hash)) {
	print "$key - $value\n";
    }

    # together with read and append
    # delete($hash{'Bonjour'});

    # untying the database
    untie %hash;

} # main

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
