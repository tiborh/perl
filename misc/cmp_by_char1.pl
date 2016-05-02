#!/usr/bin/perl -w

use strict;

&main;

sub main() {
    my $input_string1 = $ARGV[0] ? $ARGV[0] : "woes";
    my $input_string2 = $ARGV[1] ? $ARGV[1] : "noel";
    my @input_array1 = ();
    my @input_array2 = ();
    my @index_array1 = ();
    my @index_array2 = ();

    @input_array1 = &arrayify($input_string1);
    @input_array2 = &arrayify($input_string2);
    @index_array1 = &create_array_index(\@input_array1);
    @index_array2 = &create_array_index(\@input_array2);

    &cmp_by_char(\@input_array1,\@input_array2);
}

sub arrayify() {
    my $input_string = $_[0];
    my @input_array = ();

    for (0..length($input_string)-1) {
	$input_array[$_] = substr($input_string,$_,1);
    }

    return @input_array;
}

sub create_array_index() {
    my @index_array = ();
    my @input_array = @{$_[0]};

    for (0..$#input_array) {
	push @index_array,$_;
    }

    # for (0..$#index_array) {
    # 	printf("%2d: %s\n",$index_array[$_],$input_array[$_]);
    # }

    # printf("(length: %d)\n",scalar(@input_array));

    return @index_array;
}

sub cmp_by_char() {
    my @input_array1 = @{shift(@_)};
    my @input_array2 = @{shift(@_)};

    print @input_array1,"\n";
    for (0..$#input_array1) {
	print((lc($input_array1[$_]) eq lc($input_array2[$_])) ? "^" : " ");	
    }
    print "\n";
    print @input_array2,"\n";
}
