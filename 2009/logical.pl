#!/usr/bin/perl -w

$Num1=4;
$Num2=3;

print "Give me three numbers (press enter after each): \n";

chomp($Num1=<STDIN>);
chomp($Num2=<STDIN>);
chomp($Num3=<STDIN>);

$CmpNum1 = $Num1 < $Num2;
$CmpNum2 = $Num1 > $Num2;
$CmpNum3 = $Num1 == $Num2;
$CmpNum4 = $Num2 < $Num3;
$CmpNum5 = $Num2 > $Num3;
$CmpNum6 = $Num2 == $Num3;
$CmpNum7 = $Num3 < $Num1;
#$CmpNum8 = $Num3 > $Num1;
#$CmpNum9 = $Num3 == $Num1;

print "($Num1 < $Num2) || ($Num2 > $Num3): ",$CmpNum1 || $CmpNum5,"\n";
print "($Num1 = $Num2) && ($Num2 = $Num3): ",$CmpNum3 && $CmpNum6,"\n";
print "($Num1 > $Num2) xor ($Num2 < $Num3): ",$CmpNum2 || $CmpNum4,"\n";
print "($Num3 < $Num1) and ($Num1 > $Num2): ",$CmpNum7 || $CmpNum2,"\n";
