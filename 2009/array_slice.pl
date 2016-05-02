#!/usr/bin/perl -w

@alpha = ('a' .. 'z');

@slice = @alpha[4, 10 .. 15]; #array slice comma (,) and range (..) can be used

$, = " ";

print @slice,"\n";

#end of array_slice.pl
