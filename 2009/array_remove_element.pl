#!/usr/bin/perl -w

@array = ("first", "one", "two", "three", "four", "five", "last");

$, = " ";

print @array,"\n";

@popped_array = pop(@array);

print "last element is popped (",@popped_array,"\b)\n";

print @array,"\n";

@shifted_array = shift(@array);

print "first element is removed (",@shifted_array,"\b)\n";

print @array,"\n";

#end of array_remove_element.pl
