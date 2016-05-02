#!/usr/bin/perl -w

use strict;

my $gint = 0;
my $gchar = "";

while ($gchar ne "z") {
    $gint = 97+int(rand(26));
    $gchar = sprintf("%c",$gint);
    printf("%3d: %c\n",$gint,$gint);
}


