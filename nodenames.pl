#!/usr/bin/env perl

use warnings;
use strict;

my $maxnum = (exists $ARGV[0] && defined $ARGV[0] && $ARGV[0] =~ /\d+/) ? $ARGV[0] : 100;
my $nodename = (exists $ARGV[1] && defined $ARGV[1]) ? $ARGV[1] : "nodename";
my $numwidth = length("$maxnum");

printf("%s%0${numwidth}d, ",$nodename,$_) for (0..$maxnum);
