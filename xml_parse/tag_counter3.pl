#!/usr/bin/perl -w

use strict;

my $DEBUG = 0;

my %collect_hash = ();
my $file_string = "";
while (<>) {
    chomp;
    $file_string .= $_;
    #print "|",$_,"|\n";
}
#print "$file_string\n";
{
    my @caught_str = ($file_string =~ /<[^>?!]+>/g);
    foreach (@caught_str) {
#	print $_,"\n";
	next if /<\/.+>/;
	s/<([^>\s]+).*>/$1/;
	$collect_hash{$_}++;
    }
}
foreach (sort keys %collect_hash) {
    print "$_", ($DEBUG) ? " => $collect_hash{$_}\n" : "\n";
}
print scalar(keys %collect_hash),"\n";
