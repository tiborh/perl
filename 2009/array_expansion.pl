#!/usr/bin/perl -w

@nums = (3, 4, 5);

$nums[4] = 7; # (3, 4, 5, undef, 7) expected (error message for [3])

$, = "\n";

print @nums,"\n";

#end of array_expansion.pl
