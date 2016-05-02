#!/usr/bin/perl

use strict;

printf("Enter some numbers:\n");
my @numbers = split(" ",<STDIN>);
my $user_total = total(@numbers);
my $mean = $user_total/(++$#numbers);
my @above_mean = &above_mean($mean,@numbers);

printf("The sum of your numbers is: $user_total.\n");
printf("The numbers of above mean: @above_mean (mean: $mean).\n");

sub total {
    my $sum = 0;

    foreach my $number (@_) {
	$sum += $number;
    }
    return $sum;
}

sub above_mean {
    my $mean = shift(@_);
    my @above_mean;

    foreach (@_) {
	if ($_ > $mean) {
	    push(@above_mean,$_);
	}
    }

    return @above_mean;
}

# end of above_mean.pl
