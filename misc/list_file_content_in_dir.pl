#!/usr/bin/perl -w

use strict;
use Cwd;

if ($#ARGV < 0) {
    printf("you need a directory name as argument\n");
    exit(1);
} else {
    chdir $ARGV[0] || die "cannot cd to '$ARGV[0]' ($!)";
}

my $pwd = getcwd;
my @directory_list = <$pwd/*>;
print "$_\n" for (@directory_list);

foreach (@directory_list) {
    open (my $fh, "<", $_) or die "cannot open '$_': $!";
    my @file_content = <$fh>;
    close $fh;
    my $filename = substr($_, length($pwd)+1);
    print "$filename:\n";
    print "=" x (length($filename) + 1),"\n";
    print for (@file_content);
    my $num_of_lines = $#file_content + 1;
    print "($num_of_lines lines)\n";
    print "\n";
}
