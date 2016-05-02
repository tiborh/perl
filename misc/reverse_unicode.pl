#!/usr/bin/perl -w
#this program does not work as it should with unicode characters.
#sometimes it complains about 'wide character' but makes fine output
#other times it does not complain but the output is wrong
use utf8;
use Unicode::Normalize;
use charnames ':full';
use String::Multibyte;

binmode STDOUT,':utf8';
binmode STDIN,':utf8';

my $outfile = "reversed.txt";
my @rray = ();
my $filehandler = "OUTFILE";
my $str_uni = String::Multibyte->new('Grapheme');

@rray = <STDIN> or die "Program terminated: Input array is empty\n";

open($filehandler, ">", $outfile) or die "Cannot open $outfile: $!\n";

#the problem with 'reverse' is that it swaps the bytes and not the order of characters in a string
#so unicode characters won't be recognised afterwords
for (my $i = $#rray; $i >= 0; $i--) {
    chomp $rray[$i];
    $rray[$i] = NFKD $rray[$i];
    print $filehandler $str_uni->strrev($rray[$i]);
    print $filehandler "\n";
}

close($filehandler);
