#!/usr/bin/perl -w
use strict;
use utf8;
binmode STDOUT, ":utf8";

# checklist:
# files:
# ok. flock(fh,id)

# ok. rename(from,to)
# ok. File::Copy
# ok. copy(from,to)
# ok. unlink(what)
# ok $variable = (stat(filename))[1..13] 7 is size

# directories:
# ok. opendir(dir_handle,directoryfilename)
# ok. @ = readdir(dir_handle)
# ok. closedir(dir_handle)

# ok. chdir(dirfilename)
# ok. mkdir(dirfilename)
# ok. rmdir(dirfilename) (only works if empty)
# ok. chdir('..')
# ok. opendir(dh,'.')

my $mydebug = (defined($ARGV[0]) and $ARGV[0] eq "debug") ? 1 : 0;
my $max_filesize = 1000;
my $max_testfiles = 10;

sub main {
    {
	my $workspace = "workspace" . int(rand(10000));
	my $test_dir = "test_dir" . time();
	my @test_files = ();
	push @test_files, "testfile$_" foreach (0..$max_testfiles-1);
	print "<h1>File/Directory operations</h1>\n";
	print "<p>We are starting in an empty workspace:</p>\n";
	mkdir($workspace) or die "<p>creating $workspace has failed, $!</p>";
	print "<p>Workspace (<tt>$workspace</tt>) has been created.</p>\n";
	&olc_dir('.') if ($mydebug);
	&olc_dir($workspace);
	chdir($workspace);
	print "<h2>Creating a directory</h2>\n" if ($mydebug);
	mkdir($test_dir);
	print "<p>Directory <tt>$test_dir</tt> has been created.</p>\n";
	&olc_dir($test_dir);
	print "<h2>Changing directory</h2>\n";
	chdir($test_dir);
	print "<p>Directory <tt>$test_dir</tt> is now the pwd.</p>\n";
	sleep 30 if ($mydebug);
	print "<h2>Creating files</h2>\n";
	foreach (@test_files) {
	    my $fh;
	    my $fn = $_;
	    open($fh,">",$fn);
	    print $fh "x" x int(rand($max_filesize));
	    close($fh);
	}
	#chdir('..');
	&olc_dir("../$test_dir");
	#chdir($test_dir);
	print "<h2>File data</h2>\n";
	{
	    my %stat_info = (
		0 => "dev: device number of filesystem",
		1 => "ino: inode number",
		2 => "mode: file mode (type and permissions)",
		3 => "nlink: number of (hard) links to the file",
		4 => "uid: numeric user ID of file's owner",
		5 => "gid: numeric group ID of file's owner",
		6 => "rdev: the device identifier (special files only)",
		7 => "size: total size of file, in bytes",
		8 => "atime: last access time in seconds since the epoch",
		9 => "mtime: last modify time in seconds since the epoch",
		10 => "ctime: inode change time in seconds since the epoch (*)",
		11 => "blksize: preferred I/O size in bytes for interacting with the file (may vary from file to file)",
		12 => "blocks: actual number of system-specific blocks allocated on disk (often, but not always, 512 bytes each)"
	    );
	    my $fh;
	    my $fn = "mytestfile.txt";
	    open($fh,">",$fn);
	    print $fh "x" x int(rand($max_filesize));
	    close($fh);
	    my @filedata = stat($fn);
	    print "<p>File data for $fn:</p>\n";
	    print "<table>\n";
	    print "<tr>\n\t<th>index</th>\n\t<th>value</th>\n\t<th>explanation</th>\n</tr>\n";
	    print "<tr>\n\t<td>$_</td>\n\t<td>$filedata[$_]</td>\n\t<td><i>$stat_info{$_}</i></td>\n</tr>\n" foreach (0..12);
	    print "</table>\n";
	    unlink($fn);
	}
	#print "<p>Getting the stat info about</p>\n";
	print "<h2>Renaming files</h2>\n";
	my @changed_test_files = @test_files;
	s/testfile/changed/ foreach @changed_test_files;
	print "<p>testfile names: @test_files</p>\n";	
	foreach (0..$max_testfiles-1) {
	    my $fn = $test_files[$_];
	    my $tn = $changed_test_files[$_];
	    rename($fn,$tn);
	}
	&olc_dir("../$test_dir");
	print "<h2>Copying files</h2>\n";
	{
	    use File::Copy;
	    my $ctd = "copy_target_dir";
	    mkdir($ctd);
	    foreach (@changed_test_files) {
		my $fn = $_;
		my $tn = "$ctd/copied_$_";
		copy($fn,$tn);
	    }
	    &olc_dir($ctd);
	    unlink("$ctd/copied_$_") foreach (@changed_test_files);
	    rmdir($ctd);
	}
	print "<h2>Changing file permissions</h2>\n";
	print "<p>changing file permissions to 0600.</p>\n";
	chmod 0600, @changed_test_files;
	&olc_dir("../$test_dir");
	# for further expansion:
	#print "<h2></h2>\n";
	#print "<p></p>\n";
	print "<h2>Deleting files</h2>\n";
	unlink($_) foreach (@changed_test_files);
	chdir('..');
	&olc_dir($test_dir);
	print "<h2>Removing the test directory</h2>\n";
	rmdir($test_dir) or die "Cannot remove $test_dir, $!";
	print "<p>Directory <tt>$test_dir</tt> has been removed.</p>\n";
	chdir('..');
	rmdir($workspace) or die "Cannot remove $workspace, $!";
	print "<p>Workspace (<tt>$workspace</tt>) has been deleted.</p>\n";
    }
}

sub olc_dir {
    my $dh;
    my $dn = $_[0];
    opendir($dh,$dn) or die "opendir() for $dn has failed: $!";
    my @dir_content = readdir($dh);
    @dir_content = sort @dir_content;
    #$" = "<br />\n";
    print "<p>$dn content:";
    foreach (@dir_content) {
	my $sizevar = int(log($max_filesize)/log(10))+1;
	my $printout = "<br />\n%s (%0".$sizevar."d, %04o)";
	#print "<p>$printout</p>\n";
	printf($printout,$_,(stat("$dn/$_"))[7],(stat("$dn/$_"))[2] & 07777);
    }
    print "</p>\n";
    #$" = " ";
    close $dh;
}

&cgi_head("file operations");
&main();
&cgi_foot();
exit;

sub cgi_head {
print <<"EOT";
Content-type: text/html\n
<!doctype html>
<html lang="en">
<head>
\t<meta charset="utf-8">
\t<title>$_[0]</title>
</head>
<body>
EOT
}

sub cgi_foot {
print <<"EOT";
</body>
</html>
EOT
}
