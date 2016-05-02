#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

my $title = "Finding files and directories";
my $excluded_dir = "ageofempires.co.nz";

sub main {
    print <<EOT;
<h1>$title</h1>
<p>The <code>File::Find</code> module can be used to find files and directories in the file system.</p>
EOT

    {
	use File::Find;
	print "<h2>Printing out both files and directories</h2>";
	print "<h3>Version 1: everything</h3>\n";	
	print "<pre>\n";
	#find sub {print "$File::Find::name\n"}, '.';  # the simple way
	find (			# for more parameters to apply
	    {
		wanted => \&findfiles,
		#bydepth => 1,	# several options are available
	    },
	    '.'			# any path can be written here
	    );
	print "</pre>\n";
	sub findfiles {
	    print "$File::Find::name\n"; # everything (same as simple)
	}
	print "<h3>Version 2: excluding directory <code>$excluded_dir</code></h3>\n";
	print "<pre>\n";
	#find sub {print "$File::Find::name\n"}, '.';  # the simple way
	find (
	    {
		wanted => \&findfilesprunedir,
	    },
	    '.'
	    );
	print "</pre>\n";
	sub findfilesprunedir {
	    $File::Find::prune = 1 if /ageofempires.co.nz/;
	    print "$File::Find::name\n";
	}
	print "<h2>Printing out directories only</h2>";
	print "<h3>Version 1</h3>\n";
	print "<pre>\n";
	find (
	    {
		wanted => \&finddirs,
	    },
	    '.'
	    );
	print "</pre>\n";
	sub finddirs {
	    print "$File::Find::dir\n";	# directories only
	}
	print "<h3>Version 2</h3>\n";
	print "<pre>\n";
	find (
	    {
		wanted => \&finddirs2,
	    },
	    '.'
	    );
	print "</pre>\n";
	sub finddirs2 {
	    print "$File::Find::name\n" if -d; # only if directory (no duplicates)
	}
	print "<h2>Printing out files only</h2>";
	print "<h3>Version 1</h3>\n";
	print "<pre>\n";
	find (
	    {
		wanted => \&findfilesonly,
	    },
	    '.'
	    );
	print "</pre>\n";
	sub findfilesonly {
	    print "$_\n";		# files only
	}
	print "<h3>Version 2: text files only (not binary)</h3>\n";
	print "<pre>\n";
	find (
	    {
		wanted => \&findfilesonly2,
	    },
	    '.'
	    );
	print "</pre>\n";
	sub findfilesonly2 {
	    print "$File::Find::name\n" if -T; # only if text file (opposed to binary)
	}
    }

}

require "html.cgi";

&cgi_head("$title");
&main();
&printcode($0);
&cgi_foot();
exit;
