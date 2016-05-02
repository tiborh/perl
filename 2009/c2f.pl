#!/usr/bin/perl -w

#c2f.pl
#A Celsius to Fahrenheit converter.

#give prompt:
print "Celsius to Fahrenheit converter\n";
print "Temperature in Celcius > ";

#chopping off trailing \n
chomp($cels =<STDIN>);

$fahr = (($cels * 9) / 5) + 32;

#print the result
print "$cels C = $fahr F\n";

#end of c2f.pl
