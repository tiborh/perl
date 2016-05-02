#!/usr/bin/perl -w

use strict;

my ($key,$value);
my $strl=0;

foreach $key (keys %ENV) {
    if (length($key)>$strl) {
	$strl = length($key);
    }
}

my $format = "$strl"."s";

while(($key,$value) = each(%ENV)) {
    printf("%-$format = %s\n",$key,$value);
}
