#!/usr/bin/perl -w

use strict;
use Getopt::Std;
use Data::Dumper;

my %opts;
my @theOpts = qw/h i v/;
my $theOpts = join($","@theOpts");
my $debug = 0;

print "No command line arguments. Defaults are used.\n" unless scalar(@ARGV);

getopt($theOpts,\%opts);

print Dumper(%opts) if $debug;

for (@theOpts) {
    if (exists $opts{$_}) {
	print "$_: $opts{$_}\n";
    }
}
