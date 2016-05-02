#!/usr/bin/perl -w

use strict;

&main;

sub main() {
    my $input_string = $ARGV[0] ? $ARGV[0] : "Methinks it is like a weasel";
    my @input_array = ();
    my @index_array = ();

    @input_array = &arrayify($input_string);
    @index_array = &print_array_by_index(\@input_array);
}

sub arrayify() {
    my $input_string = $_[0];
    my @input_array = ();

    for (0..length($input_string)-1) {
	$input_array[$_] = substr($input_string,$_,1);
    }

    return @input_array;
}

sub print_array_by_index() {
    my @index_array = ();
    my @input_array = @{$_[0]};

    for (0..$#input_array) {
	push @index_array,$_;
    }

    for (0..$#index_array) {
	printf("%2d: %s\n",$index_array[$_],$input_array[$_]);
    }

    printf("(length: %d)\n",scalar(@input_array));

    return @index_array;
}
