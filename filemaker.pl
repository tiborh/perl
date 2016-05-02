#!/usr/bin/perl -w

use strict;

my $fnRoot = ($ARGV[0] ? $ARGV[0] : "sample");
my $nuOfFiles = ($ARGV[1] && int($ARGV[1]) ? $ARGV[1] : "5");
my $nuOfChars = ($ARGV[2] && int($ARGV[2]) ? $ARGV[2] : "100");
my $nuOfDigits = 1+int(log($nuOfFiles)/log(10));
my $printStr = "%s%0$nuOfDigits"."d.txt"; 
my $theTimeStamp = &makeTimeStamp();
my $dirName = sprintf("%s_%s",$fnRoot,$theTimeStamp);

&makeDir($dirName);

chdir $dirName or die "Cannot change dir to $dirName: $!";

for(my $i=0;$i<$nuOfFiles;$i++) {
    my $fn=sprintf($printStr,$fnRoot,$i);
    open FILE, ">", $fn or die $!;
    print FILE "0" x  int(rand($nuOfChars));
    close FILE;
}

sub makeTimeStamp {

my @art = localtime(time);
my $timestamp = sprintf("%4d%02d%02d_%02d%02d%02d",$art[5]+1900,++$art[4],$art[3],$art[2],$art[1],$art[0]);

return $timestamp;
}

sub makeDir {
    my $dirName = $_[0];

    if (-f $dirName) {
	print "'$dirName' is a plain file.\n";
	exit 0;
    } elsif (-d $dirName) {
	print "Directory '$dirName' already exists.\n";
    } else {
	mkdir $dirName, 0755 or warn "Cannot create directory $dirName: $!";
    }

}
