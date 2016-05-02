#!/usr/bin/perl -w

$num1=4;
$num2=3;

print "Give me two numbers (press enter after each): \n";

chomp($num1=<STDIN>);
chomp($num2=<STDIN>);

$Exp = $num1**$num2;
$Div = $num2/$num1;
$Div2 = int($num1/$num2);

print "$num1 raised to the power of $num2 is $Exp\n";
print "$num2 divided by $num1 is $Div\n";
print "$num1 divided by $num2 is ",$num1/$num2," \n";
print "$num1 divided by $num2 is $Div2 (integer conversion)\n";
print "Let's round the products of the divisions:\n";
$Prod1 = int($num1/$num2+0.5);
$Prod2 = int($num2/$num1+0.5);
print "round(num1/num2) = $Prod1; round(num2/num1) = $Prod2\n"
