#!/usr/bin/perl

$inline="";
@numbers=();

print "Two numbers (space-separated): ";
chomp($inline=<STDIN>);
@numbers=split(" ",$inline);

printf("a = %f\n",@numbers[0]);
printf("b = %f\n",@numbers[1]);
printf("a * b = %f\n",@numbers[0]*@numbers[1]);

#end of multiply_two_exp.pl
