#!/usr/bin/perl

do {
    print "How many rolls of the dice? ";
    chomp($nuOfRolls = <STDIN>);
} while ($nuOfRolls <= 0);

$nuOfRolls = int($nuOfRolls);

for($i=0;$i<$nuOfRolls;$i++) {
    $roll = int(rand 6) + 1;
    $rolls{$roll}++; #collecting in a hash which number how many times
}

$i = scalar keys %rolls;

$average = $nuOfRolls / $i;

foreach $rollrec (sort keys %rolls) {
    $sign = "";
    $deviance = (($average - $rolls{$rollrec})/$average)*100;
    if ($deviance > 0) { $sign = "+" };
    printf("%d: %d (%s%4.2f\%)\n",$rollrec,$rolls{$rollrec},$sign,$deviance);
}

printf("average: %5.2f\n",$average);

