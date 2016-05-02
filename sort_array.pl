#!/usr/bin/perl -w

my @rray = qw(alpha beta gamma delta epsylon);

my @rr_input = ();

chomp(@rr_input = <STDIN>);

@rray = (@rr_input) ? sort @rr_input : sort @rray;

$" = "\n";

print "@rray\n";
