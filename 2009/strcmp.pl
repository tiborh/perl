#!/usr/bin/perl -w

$Str1=4;
$Str2=3;

print "Give me two strings (press enter after each): \n";

chomp($Str1=<STDIN>);
chomp($Str2=<STDIN>);

print "cmp: ",$Str1 cmp $Str2,"\n";
print "eq: ",$Str1 eq $Str2,"\n";
print "ne: ",$Str1 ne $Str2,"\n";
print "gt: ",$Str1 gt $Str2,"\n";
print "lt: ",$Str1 lt $Str2,"\n";
