#!/usr/bin/perl -w

use strict;
use Getopt::Std;

my %cli_opts = ();

print "Usage: $0 -h" if (scalar(@ARGV) == 0);

getopt('h', \%cli_opts);

print "This is the help.\n" if (exists $cli_opts{'h'});
