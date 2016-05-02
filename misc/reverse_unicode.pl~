#!/usr/bin/perl -w

use utf8;

binmode STDOUT,':utf8';

my $outfile = "reversed.txt";
my @rray = ();
my $filehandler = "OUTFILE";

@rray = <STDIN> or die "Program terminated: Input array is empty\n";

open($filehandler, ">", $outfile) or die "Cannot open $outfile: $!\n";

#the problem with 'reverse' is that it swaps the bytes and not the order of characters in a string
#so unicode characters won't be recognised afterwords
for (my $i = $#rray; $i >= 0; $i--) {
    chomp $rray[$i];
    print $filehandler scalar reverse $rray[$i];
    print $filehandler "\n";
}

close($filehandler);
