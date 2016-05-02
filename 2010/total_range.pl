#!/usr/bin/perl -w

printf("Enter two numbers:\n");
my @nums = ();
my $user_total = 0;
@nums = split(" ",<STDIN>);
if ($nums[0]<$nums[1]) {
    $user_total = total($nums[0]..$nums[1]);
} else {
    $user_total = total($nums[1]..$nums[0]);
}
printf("The sum of your range ($nums[0]..$nums[1]) is: $user_total.\n");

sub total {
    my $sum = 0;

#    printf("@_\n");
    foreach my $number (@_) {
	$sum += $number;
    }
    return $sum;
}
# end of total_range.pl
