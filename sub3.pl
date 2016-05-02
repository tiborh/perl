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

($sum_of_nums,@rr_input) = &total_nums(@rr_input);

print "Sum of the elements: $sum_of_nums\n";

@array = &above_average($sum_of_nums,@rr_input);

print "The value(s) above average: @array\n";

sub total_nums {
    my $total_num = 0;

    if (!@_) {
	@_ = &fill_arr(@_);
    }

    print "Elements used: @_\n";

    foreach my $anElement (@_) {
	$total_num += $anElement;
    }
    return ($total_num,@_);
}

sub fill_arr {
    my $num_of_elems = int(rand(100));

    print "Number of elements: $num_of_elems\n";
    
    for (my $i=0; $i<$num_of_elems; $i++) {
	$_[$i] = int(rand(100));
    }
    return @_;
}

sub above_average {
    my $total = shift(@_);
    my $number_of_elements = $#_ + 1;
    my @aboveAverage = ();

    my $the_average = &average($total,$number_of_elements);

    print "The average value is: $the_average\n";

    foreach my $elems (@_) {
	if ($elems > $the_average) {
	    push(@aboveAverage,$elems);
	}
    }
    return @aboveAverage;
}

sub average {
    return $_[0] / $_[1];
}
