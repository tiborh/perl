#!/usr/bin/perl -w

use strict;

my @ar_elems = ();

#a subroutine changes a copy of the passed array, not the array.
@ar_elems = &fill_arr(@ar_elems);

print "contents of the array: @ar_elems\n";

sub fill_arr {
    my $num_of_elems = int(rand(100));

    print "number of elements: $num_of_elems\n";
    
    for (my $i=0; $i<$num_of_elems; $i++) {
	$_[$i] = int(rand(100));
    }
    return @_;
}
