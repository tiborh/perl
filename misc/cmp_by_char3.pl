#!/usr/bin/perl -w

use strict;

&main;

sub main() {
    my $input_string1 = $ARGV[0] ? $ARGV[0] : "woes";
    my $input_string2 = $ARGV[1] ? $ARGV[1] : "noel";
    my @input_array1 = ();
    my @input_array2 = ();
    my @index_array1 = ();

    @input_array1 = &arrayify($input_string1);
    @input_array2 = &arrayify($input_string2);
    @index_array1 = &create_array_index(\@input_array1);

    &cmp_by_index(\@input_array1,\@index_array1,\@input_array2);
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

    return @index_array;
}

sub cmp_by_index() {		# stringarray1, index1, stringarray2
    my @input_array1 = @{shift(@_)};
    my @index_array1 = @{shift(@_)};
    my @input_array2 = @{shift(@_)};
    my @index_array_copy = @index_array1;
    my @collect_symbols = ();

    if (scalar(@input_array1) != scalar(@input_array2)) {
	print "String lengths are not equal. Exiting...\n";
	exit -1;
    }

    print @input_array1,"\n";
    for (my $i = $#index_array1; $i >= 0; $i--) {
	if (lc($input_array1[$index_array1[$i]]) eq lc($input_array2[$index_array1[$i]])) {
	    $collect_symbols[$i]="^";
	    splice @index_array_copy,$i,1;
	    } else {
		$collect_symbols[$i]=" ";
	    }
	#print "\$i: $i\n index_array_copy: @index_array_copy\n";
    }
    print @collect_symbols,"\n";
    print @input_array2,"\n";
    print "@index_array_copy\n";
    return @index_array_copy;
}
