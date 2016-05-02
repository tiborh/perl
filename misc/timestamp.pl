#!/usr/bin/perl -w

use strict;

my $timestamp = "";

my @art = localtime(time);

$timestamp = sprintf("%4d%02d%02d_%02d%02d%02d",$art[5]+1900,++$art[4],$art[3],$art[2],$art[1],$art[0]);

print("$timestamp\n");
