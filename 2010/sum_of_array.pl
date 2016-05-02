#!/usr/bin/perl -w

use 5.010;

running_sum(5,6);
running_sum(1..3);
running_sum(4);

sub running_sum {
    state $sum = 0;
    state @numbers;

    foreach my $number (@_) {
	push(@numbers,$number);
	$sum += $number;
    }
    printf("The sum of (@numbers) is $sum\n");
}
# end of sum_of_array.pl
