#!/usr/bin/perl

$Num1=4;
$Num2=3;

print "Give me two numbers (press enter after each): \n";

chomp($Num1=<STDIN>);
chomp($Num2=<STDIN>);

($Num1 < $Num2 ? $Less : $Greater) = $Num1;
($Num2 < $Num1 ? $Less : $Greater) = $Num2;

($Greater == undef) || ($Less == undef) ? print "$Num1 = $Num2\n" : print "Less: $Less, Greater: $Greater\n";
