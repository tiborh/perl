#!/usr/bin/perl -w

$String1 = "alpha";
$String2 = "beta";
@alpha = ("alpha", "beta", "gamma", "delta");

print "We have two strings, $String1 and $tring2.\n";

print "Now we join them with the join() function:", join($String1, $String2), "\n";

print "When you join a scalar with an array, you join the scalar to each member ot the array.\n";

print @alpha,"\n";
print join(' ',@alpha),"\n";
