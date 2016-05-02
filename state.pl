#!/usr/bin/perl -w

#use strict;
use 5.010;

print "Give names: \n";
while (<STDIN>) {
    chomp;
    &greet_people($_);
}

sub greet_people {
    state @people;

    print "Hello $_[0]! ";
    if (!@people) {
	print "You are the first one here.\n";
    } else {
	print "I've seen: @people\n";
    }
    push(@people,$_[0]);
}
