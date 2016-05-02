#!/usr/bin/perl -w

use strict;

my $start_num = 0;
my $end_num = 0;
my $sum_of_nums = 0;

if ($#ARGV < 1) {
    if ($#ARGV == 0) {
	print "Only one number found: starting number is zero.\n";
	$end_num = $ARGV[0];
    } else {
	do {
	    print "No argument found. Starting number: zero; End number: random\n";
	    $end_num = int(rand(100));
	} while ($end_num <= 0);
    }
} else {
    $start_num = $ARGV[0];
    $end_num = $ARGV[1];
}

print "Starting number: $start_num\n";
print "End number: $end_num\n";
$sum_of_nums = &total_nums($start_num,$end_num);
print "Sum of the numbers: $sum_of_nums\n";

sub total_nums {
    my $total_num = 0;

    if ($_[0] > $_[1]) {
	($_[0],$_[1]) = ($_[1],$_[0]);
    }

    for (my $i = $_[0]; $i <= $_[1]; $i++) {
	$total_num += $i;
    }

    return $total_num;
}
