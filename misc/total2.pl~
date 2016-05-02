#!/usr/bin/perl -w

use strict;

my $start_num = 0;
my $end_num = 0;
my @in_array = ();
my $total_num = 0;
my @input_lines = ();

if ($#ARGV < 1) {
    print "Give a starting and end number\n";
    chomp(@input_lines = <STDIN>);
    if ($#input_lines) {
	$start_num = $input_lines[0];
	$end_num = $input_lines[1];
    } else {
	($start_num,$end_num) = split /\s+/, $input_lines[0];
    }
} else {
    $start_num = $ARGV[0];
    $end_num = $ARGV[1];
}

if (!$start_num) {
    print "Start and end number are not defined.\n";
    $total_num = &total_nums(());
} elsif (!$end_num) {
    print "End number is not defined.\n";
    $total_num = &total_nums(());
} else {
    @in_array = ($start_num < $end_num) ? $start_num..$end_num : ();
    $total_num = &total_nums(@in_array);
    print "Starting number: $start_num\n";
    print "End number: $end_num\n";
}

print "Sum of numbers: $total_num\n";

sub total_nums {
    my $total_num = 0;

    if (!@_) {
	@_ = &fill_arr(@_);
    }

    print "Elements used: @_\n";

    foreach my $anElement (@_) {
	$total_num += $anElement;
    }
    return $total_num;
}

sub fill_arr {
    my $num_of_elems = int(rand(100));

    print "Using random numbers.\n";
    print "Number of elements: $num_of_elems\n";
    
    for (my $i=0; $i<$num_of_elems; $i++) {
	$_[$i] = int(rand(100));
    }
    return @_;
}
