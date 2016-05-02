#!/usr/bin/env perl

use warnings;

printf("%3d %4d\n",$_,multiply_by_10($_)) foreach (1..10);
printf("%d\n",multiply_by_10(9223372036854775807)); # it does not die, just overflows

sub multiply_by_10()
{
    my $num = $_[0];
    my $collector = "$num" + "0"; # not converted to string :)
    return $collector + 0;
}
