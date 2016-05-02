#!/usr/bin/perl -w

use strict;
use Cwd;
use Time::Piece;
use File::Basename;
use File::Copy;
use Getopt::Std;
use v5.14;

my $DEBUG = 0;

my $the_path = "";
my $timestamp = &get_timestamp;
my $tmp_dir_name = "tmp_" . $timestamp;

if ($#ARGV < 0) {
    printf("you need a directory name (with absolute path) as an argument (with no trailing slash)\n");
    exit(1);
} else {
    $the_path = $ARGV[0];
    die "'$the_path' does not exist" if (! -e $the_path);
    die "'$the_path' is not a directory" if (! -d $the_path);
}

my @epub_files = ();
&dir_crawler($the_path);
print "temporary epub directory: $tmp_dir_name\n";
mkdir $tmp_dir_name;

#print "$_\n" for (@epub_files);

for (@epub_files) {
    my $the_basename = basename $_;
    my $the_destination = $tmp_dir_name . "/" . $the_basename;
    print "copying $_\n\tto $the_destination\n";
    copy ($_,$the_destination);
}

sub dir_crawler {
    my @dir = <$_[0]/*>;
    for (@dir) {
	push(@epub_files,$_) if /.*\.epub$/;
	&dir_crawler($_) if -d;
    }
}

sub get_timestamp {
    my @art = localtime(time);
    my $timestamp = sprintf("%4d%02d%02d_%02d%02d%02d",$art[5]+1900,++$art[4],$art[3],$art[2],$art[1],$art[0]);

    return $timestamp;
}
