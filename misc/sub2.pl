#!/usr/bin/perl -w

use strict;

my @rr_input = ();
my @array = ();
my $sum_of_nums = 0;

print << "EOF";
The script sums up the elements of line separated number list.
The list of numbers can be entered on the keyboard or through a pipe.
If neither of the above is provided (^D), a random list will be used.
EOF

chomp(@rr_input = <STDIN>);

$sum_of_nums = &total_nums(@rr_input);

print "Sum of the elements: $sum_of_nums\n";

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

    print "Number of elements: $num_of_elems\n";
    
    for (my $i=0; $i<$num_of_elems; $i++) {
	$_[$i] = int(rand(100));
    }
    return @_;
}
