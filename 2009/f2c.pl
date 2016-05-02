#!/usr/bin/perl -w

#f2c.pl
#A Fahrenheit to Celsius converter.

#give prompt:
print "Fahrenheit to Celsius Converter\n";
print "Temperature in Fahrenheits > ";

#chopping off trailing \n
chomp($fahr =<STDIN>);

$cels = (($fahr - 32) * 5) / 9;

#print the result
print "$fahr F = $cels C\n";

#end of f2c.pl
