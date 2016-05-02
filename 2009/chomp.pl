#!/usr/bin/perl
  use strict;
  use warnings;

  while (my $text = <STDIN>) {
    chomp($text);
    print "You entered '$text'\n";
    last if ($text eq '');
  }
