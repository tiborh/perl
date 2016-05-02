#!/usr/bin/perl -w

use strict;

if ($#ARGV >= 0) {
    for (@ARGV) {
	open (my $infile, "<", $_) or die "cannot open '$_': $!";
	
	while (<$infile>) {
	    chomp;
	    printf("%s ",$_) if (s/.*\s([A-Z]{2}[0-9]{5}).*/$1/);
	}
	close ($infile);
    }
    print "";
} else {
    print "You need to give the filename(s) of txt file(s) containing TR numbers.";
}
