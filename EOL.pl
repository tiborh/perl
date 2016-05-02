#!/usr/bin/perl -w

my $str_collect = "";

open OUTFILE, ">dump.txt" or die $!;

while(<>) {
   $str_collect .= $_;
}

$_ = $str_collect;
s|\r\n|\n|g;
s/(.*)(?<=\s)\n/$1/g;
s/(.*)\n(?=\s)/$1/g;
s/(.*)(?<=>)\n/$1/g;
s/(.*)\n(?=>)/$1/g;
s/(.*)(?<=\S)\n(?=\w)/$1 /g;
s/(.*)(?<=\w)\n(?!\s)/$1 /g;

print OUTFILE $_;
close OUTFILE;
