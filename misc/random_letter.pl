#!/usr/bin/perl -w

use strict;

my $gchar = 97+int(rand(26));
my $gcap = $gchar-32;
printf("%3d: %c\n",$gchar,$gchar);
printf("%3d: %c\n",$gcap,$gcap);
