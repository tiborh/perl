#!/usr/bin/perl -w

@alpha1 = ("a", "b", "c");
@alpha2 = ("d", "e", "f");

unshift @alpha2, @alpha1; #places list alpha1 in front of list alpha2

$, = " "; # Prints a space in between elements, that is, sets output field operator to <space>

print @alpha2, "\n";
