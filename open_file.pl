#!/usr/bin/perl -w

use strict;

#the recommended way to open a file is with three args:
my $fh;		# name of file handler, uninitialised scalar
my $fma = ">>"; 			# for appending
my $fmr = "<"; 				# for reading
my $fn = "test_file.txt";		# name of the file
my $ts = localtime(time());		# time stamp
my $wl = int(rand(12))+1;		# word length

open($fh,$fma,$fn) or die "Unable to open $fn.\n $!";

printf($fh "[%s] %s\n",$ts,&gen_word($wl));

open($fh,$fmr,$fn) or die "Unable to open $fn.\n $!";

print <$fh>;

close($fh);

sub gen_word {
    my $gword = "";
    for (my $i = 0; $i < $_[0]; $i++) {
    $gword .= sprintf("%c",97+int(rand(26)));
    }
    return $gword;
}
