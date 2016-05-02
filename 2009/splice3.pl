#!/usr/bin/perl -w

@lcolours = ("white", "yellow", "pink");
@dcolours = ("black", "blue", "brown");
$lcol = "cyan";
$dcol = "purple";
#@colours = (@lcolours, @dcolours);

splice(@colours,0,0,@lcolours); #the splice function does not return anything.

$, = " ";

print "light colours added: @colours\n";

splice(@colours,@colours,0,@dcolours);

print "dark colours added: @colours\n";
