#!/usr/bin/perl -w

use strict;

my $file_root = $ARGV[0] ? $ARGV[0] : "default";
my $file_ext = $ARGV[1] ? $ARGV[1] : "txt";
my $file_num = $ARGV[2] ? $ARGV[2] : 12;
my $max_size = $ARGV[3] ? $ARGV[3] : 100;

foreach (1..$file_num) {
     my $fn = sprintf("%s%02d.%s",$file_root,$_,$file_ext);
     printf("%2d: ",$_);
     printf("%s\n",$fn);
     open FH,">",$fn or die $!;
     print FH "0" x int(rand($max_size));
     close FH;
}
