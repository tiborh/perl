#!/usr/bin/perl -w

$string = "This is test.";
print "The test string: \"$string\"\n"; # the whole string
print "Length of the string: ",length($string),"\n";
print "From char 6 to the end: \"",substr($string, 5),"\"\n"; 
print "2 chars starting from char 6: \"",substr($string, 5, 2),"\"\n"; 
substr($string, 7, 0, " a"); # string insertion by replacement
print "Inserting text by substitution: \"",$string,"\"\n";
print "Length of the new string: ",length($string),"\n";
#another way to substitute/insert:
substr($string, 14, 0)=" string";
print $string,"(",length($string),")\n"; 
#end of substr.pl
