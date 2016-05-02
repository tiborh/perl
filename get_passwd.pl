#!/usr/bin/perl -w

use strict;

system "stty -echo";
print "Password: ";
chomp(my $pword = <STDIN>);
print "\n";
system "stty echo";
printf "Got it: %d\n",length $pword;
