#!/usr/bin/perl -w

my $x = 0;

chvar($x++);
chvar($x);

sub chvar {
    print "true\n" if ($_[0]);
}