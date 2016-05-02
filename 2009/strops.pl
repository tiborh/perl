#!/usr/bin/perl -w

print "give me a (short) word: \n";
chomp($Str1=<STDIN>);
print "give me a (small & positive) number too: \n";
chomp($Num1=<STDIN>);

print $Str1 x $Num1,"\n";

print "Give me another (short) string: \n";
chomp($Str2=<STDIN>);

$Str3 = $Str1 . $Str2;

print "$Str3\n";
print $Str3 x $Num1,"\n"; 
#It didn't work when tried in one step: ($Str1 . $Str2) x $Num1;
#Error message:
#print (...) interpreted as function at ./strops.pl line 14.
#Useless use of repeat (x) in void context at ./strops.pl line 14.
#Useless use of a constant in void context at ./strops.pl line 14.
