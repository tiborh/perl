#!/usr/bin/perl -w

use utf8;

print "Line closed with newline (\\n) \n";
print "Line closed with form feed (\\f) \f";
print "new line after form feed \n";
print "Line closed with carriage return (\\r) \r";
print "Line closed with carriage return and form feed (\\r\\f) \r\f";
print "one two\b\b\bthree ('two' has been deleted with 3 backspaces (\\b))\n";
print "Testing bell (\\a) \a\n";
print "escape (\\e) in the \e middle of the line\n";
print "escape in octal (\\033) in the \033 middle of the line\n";
print "del in hexadecimal (\\x7f) in the \x7f middle of the line\n";
print "Control-C (\\cC) between one and two: 1 \cC 2\n";
print "Unicode smiley (\\x{263a}): \x{263a}\n";
print "Named character (\\N{}) does not work\n";

print "Uppercasing the next character (\\ue): \ue\n";
print "Lowercasing the next character (\\lM): \lM\n";
print "Uppercasing all following characters (\\Usomething\\E but not more): \Usomething\E but not more\n";
print "Lowercasing all following characters (\\LENTER\\E but not more): \LENTER\E but not more\n";
print "Backslashing all following non alphanumeric (\\Q\\ \\$ \\@ \\E): \Q\ \$ \@ \Enot more\n";

