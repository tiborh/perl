#!/usr/bin/perl -w
##!/app/perl/5.8.8/bin/perl -w

use strict;
#use Time::localtime;
#use File::stat;

my %files_and_times = ();
my $par_queried = "mtime";

die "No argument.\n" unless (@ARGV);

for (@ARGV) {
    $files_and_times{$_} = get_change_time($_,$par_queried);

}

if (@ARGV == 1) {
    print "$ARGV[0]: $files_and_times{$ARGV[0]}\n";
    print "Only one filename, nothing to sort\n";
    exit 0;
}

print "Sort by filenames:\n";
for (sort keys %files_and_times) {
    printf "%15s\t%d\n",$_,$files_and_times{$_};
}
print "\n";

print "Sort by $par_queried:\n";
for (sort {$files_and_times{$a} <=> $files_and_times{$b}} keys %files_and_times) {
    printf "%15s\t%d\n",$_,$files_and_times{$_};
}

sub get_change_time {
    my $debug = 0;
    my @labels = qw/dev ino mode nlink uid gid rdev size atime mtime ctime blksize blocks/;
    my @time_data = qw/sec min hour mday mon year wday yday isdst/;
    my @time_store = ();

    my %time_data = ();

    my %descriptive_labels = (
	$labels[0] => 'device number of filesystem',
	$labels[1] => 'inode number',
	$labels[2] => 'file mode  (type and permissions)',
	$labels[3] => 'file mode  (type and permissions)',
	$labels[4] => 'numeric user ID of file\'s owner',
	$labels[5] => 'numeric group ID of file\'s owner',
	$labels[6] => 'the device identifier (special files only)',
	$labels[7] => 'total size of file, in bytes',
	$labels[8] => 'last access time since the epoch',
	$labels[9] => 'last modify time since the epoch',
	$labels[10] => 'inode change time (NOT creation time!) since the epoch',
	$labels[11] => 'preferred block size for file system I/O',
	$labels[12] => 'actual number of blocks allocated',
	);

	die "Cannot find file '$_[0]': $!" unless (-e);
	print "$_:\n" if $debug;
	my @file_data = stat($_[0]);
	my %file_data = ();
	for (my $i = 0; $i < @labels; $i++) {
	    printf "%8s:%12s\t(%s)\n",$labels[$i],$file_data[$i],$descriptive_labels{$labels[$i]} if $debug;
	    $file_data{$labels[$i]} = $file_data[$i];
	}

    return (exists $file_data{$_[1]}) ? $file_data{$_[1]} : "";
}

