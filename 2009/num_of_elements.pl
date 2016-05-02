#!/usr/bin/perl -w

@list = ("önös", "őzek", "űrjárműve", "égve", "üget");

$, = " ";
$[ = 1; #which should be the first element?

print "zeroth element: $list[0]\n";
print "first element: $list[1]\n"; #same? an interesting solution.

print @list, "\n";

$num_of_elements = @list;

print "Number of elements in list: ", $num_of_elements, "\n";

$num_of_elements = $#list - $[ + 1;

print "The same using a different method: ", $num_of_elements, "\n";
