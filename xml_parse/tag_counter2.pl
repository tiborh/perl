#!/usr/bin/perl -w

use strict;
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
	if (/<title.*>/) {
	    $collect_hash{"<title>"}++;
	} else {
	    $collect_hash{$_}++;
	}
    }
}
foreach (sort keys %collect_hash) {
    print "$_ => $collect_hash{$_}\n";
}
print scalar(keys %collect_hash),"\n";
