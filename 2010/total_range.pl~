#!/usr/bin/perl -w

printf("Enter some numbers:\n");
my $user_total = total(split(" ",<STDIN>));
printf("The sum of your numbers is: $user_total.\n");

sub total {
    my $sum = 0;

    foreach my $number (@_) {
	$sum += $number;
    }
    return $sum;
}
# end of total.pl
