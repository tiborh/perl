#!/usr/bin/perl
  use strict;
  use warnings;

  my @array = ("bob\n", "jill", "fred\n");

  print "Before chomp:\n";
  print "@array\n";

  chomp(@array);

  print "After chomp:\n";
  print "@array\n";
