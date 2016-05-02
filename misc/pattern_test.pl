#!/usr/bin/perl -w

use strict;

sub usage {
    print "Usage:\n\t$0 '<pattern>' <string>\n";
}

if (scalar(@ARGV) < 2) {
    &usage;
    die "Missing parameter.\n";
}

my $fh;		# name of file handler, uninitialised scalar
my $fmr = "<"; 				# for reading
my $fn = $ARGV[1];		# name of the file
my $pattern = $ARGV[0];

$pattern =~ s/^'(.+)'$/$1/;
print "pattern: |$pattern|\n";

die "Empty pattern space!" if (!$pattern);

open($fh,$fmr,$fn) or die "Unable to open $fn.\n $!";

while (<$fh>) {
    chomp;
    if (/$pattern/) {
	print "Matched: |$`_$&_$'|\n";
    } else {
	print "No match: |$_|\n";
    }
}
