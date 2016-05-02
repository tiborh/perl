#!/usr/bin/perl -w

use strict;
#use encoding 'utf8'; #does not work in Debian.

my $fn = "haiku.txt";
my $fh;
open $fh,"<",$fn or die "Can't open $fn";

print while (<$fh>);
