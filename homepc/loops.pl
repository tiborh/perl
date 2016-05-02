#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

{
    my $k = 16;
    my $result = 1;
    while ($k > 0){
	$result = $result * 2;
	print("2^",(16 - $k + 1),"=",$result,"\n");
	$k--;
    }
}

{
    my $result = 1;
    for (my $k = 16; $k > 0; $k--){
	$result = $result * 2;
	print("2^",(16 - $k + 1),"=",$result,"\n");
    }
}

{
    for(my $i=0; $i<20; $i++) {
	print("*");
    }
    print("\n");
}

{
    my @numbers = (1, 4, 3, 6, 8, 5, 3, 1, 9, 7);
    my $sum = 0;
    $sum+=$_ foreach (@numbers);
    my $avg = $sum / scalar(@numbers);
    printf("The average: %d / %d == %.2f\n",$sum,scalar(@numbers),$avg);
}

{
    my @numbers = (1, 4, 3, 6, 8, 5, 3, 1, 9, 7);
    my $result = 0;
    for (my $i = 0; $i < scalar(@numbers); ++$i)
    {
	for (my $j = $i+1; $j < scalar(@numbers); ++$j)
	{
	    $result += ($numbers[$i] == $numbers[$j] ? 1 : 0);
	}
    }
    printf("Number of identical numbers: %d\n",$result);
}
