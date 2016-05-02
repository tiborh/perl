#!/usr/bin/perl -w
##!/app/perl/5.8.8/bin/perl -w

use strict;
#use Time::localtime;
#use File::stat;

my $debug = 0;

my @labels = qw/dev ino mode nlink uid gid rdev size atime mtime ctime blksize blocks/;
my @time_data = qw/sec min hour mday mon year wday yday isdst/;
my @time_store = ();

my %time_data = ();

my %labels = (
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


for (@ARGV) {
    die "Cannot find file '$_': $!" unless (-e);
    print "$_:\n";
    my @file_data = stat($_);
    my %file_data = ();
    for (my $i = 0; $i < @labels; $i++) {
	printf "%8s:%12s\t(%s)\n",$labels[$i],$file_data[$i],$labels{$labels[$i]};
	$file_data{$labels[$i]} = $file_data[$i];
    }
#    printf "human readable ctime: %s\n",ctime($file_data{"ctime"});
    @time_store = localtime($file_data{"ctime"});
    print "@time_store\n" if $debug;
    for (my $i = 0; $i < @time_store; $i++) {
	$time_data{$time_data[$i]} = $time_store[$i];
	printf "%6s:\t%3d\n",$time_data[$i],$time_store[$i] if $debug;
    }
    printf "ctime in human readable (custom) format: %04d-%02d-%02d %02d:%02d:%02d\n",1900+$time_data{"year"},++$time_data{"mon"},$time_data{"mday"},$time_data{"hour"},$time_data{"min"},$time_data{"sec"};
}

