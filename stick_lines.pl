#!/usr/bin/perl -w

my $str_collect = "";

open OUTFILE, ">dump.txt" or die $!;

while(<>) {
    s|(.*)\r|$1|;
    chomp;
    $str_collect .= $_;
}

print OUTFILE $str_collect;
close OUTFILE;

print $str_collect . "\n";
