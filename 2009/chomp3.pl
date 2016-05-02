#!/usr/bin/perl
  use strict;
  use warnings;

  my %hash = (
    'first' => "one\n",
    'second' => "two\n",
    'third' => "three\n",
  );

  chomp(%hash);

  foreach my $k (keys %hash) {
    print "$k: $hash{$k} ";
  }

  print "\n";

  exit 0;
