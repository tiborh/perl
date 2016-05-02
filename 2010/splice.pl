#!/usr/bin/perl -w

@in_array = (1..12);

print(join(" ",@in_array) . "\n");

splice(@in_array,5,6,reverse(0..3));

print(join(" ",@in_array) . "\n");

#end of splice.pl
