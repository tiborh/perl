#!/usr/bin/perl -w

use strict;

print "ARGV: @ARGV\n";

if (@ARGV < 2) {
    print "2 or 3 space-separated numbers are needed as arguments:\n <start> <end> [<increment>]\n";
    die "not enough arguments";
}
die "1st is not a valid number" unless ($ARGV[0] =~ /^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?$/);
my $start_num = int($ARGV[0]);
die "2nd is not a valid number" unless ($ARGV[1] =~ /^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?$/);
my $end_num = int($ARGV[1]);
my $increment = 1;
if ($ARGV[2]) {
    $increment = int($ARGV[2]) if ($increment =~ /^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?$/);
    die ("increment cannot be zero.\n") if ($increment == 0);
}

printf("The sum is: %d\n",&adder($start_num,$end_num,$increment));

sub adder {
    my $sum_val = 0;
    ($_[0],$_[1]) = ($_[1],$_[0]) if ($_[0] > $_[1]);
    $_[2] = 0 - $_[2] if ($_[2] < 0);
    for (my $i = $_[0]; $i <= $_[1]; $i+=$_[2]) {
	$sum_val += $i;
    }
    return $sum_val;
}
