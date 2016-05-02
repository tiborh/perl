#!/usr/bin/perl -w
use strict;

die "Two integer arguments are needed." if scalar(@ARGV) != 2;
&main(@ARGV);

sub main()
{
    my ($num1,$num2) = ($_[0],$_[1]);
    print("Input: $num1,$num2\n");
    printf("divident: %d\ndivisor: %d\nremainder: %d\n",$num1,$num2,&mod($num1,$num2));
}

sub mod()
{
    my $number = shift;
    my $modulant = shift;

    return $number % $modulant;
}
