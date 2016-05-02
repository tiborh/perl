#!/usr/bin/perl -w

use strict;
use Cwd;
use Time::Piece;
use File::Basename;
#use Getopt::Std;

if ($#ARGV < 0) {
    print "Give the filename as an argument.\n";
    exit(1);
}

my $infile;
my $to_read = "<";
my $from_filename = $ARGV[0];

open($infile,$to_read,$from_filename) or die "Cannot locate $from_filename, $!";
chomp (my @collect_list = <$infile>);
close($infile);

my %collect_hash;

$collect_hash{$_} = [ split /\//,$collect_list[$_] ] for (0 .. $#collect_list);

#print $collect_list[0][0];

print "$_: @{$collect_hash{$_}}\n" for (sort keys %collect_hash);

#print $collect_list[0]."\n";
#print $collect_list[-1]."\n";



