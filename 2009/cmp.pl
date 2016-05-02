#!/usr/bin/perl -w

$Num1=4;
$Num2=3;

print "Give me two numbers (press enter after each): \n";

chomp($Num1=<STDIN>);
chomp($Num2=<STDIN>);

$CmpNum = $Num1 <=> $Num2;

print "<=>: $CmpNum\n";

if ($CmpNum == 1)
{
    print "$Num1 is greater than $Num2\n";
}
elsif ($CmpNum == 0)
{
    print "$Num1 is equal to $Num2\n";
}
else
{
    print "$Num1 is less than $Num2\n";
}
