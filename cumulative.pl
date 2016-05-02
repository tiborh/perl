#!/usr/bin/perl -w

use strict;

&main;

sub main() {
    my $target_string = $ARGV[0] ? $ARGV[0] : "Methinks it is like a weasel";
    my @char_pool = ("a".."z"," ");
    my @guess = ();
    my @input_array = ();
    my @index_array = ();

    push @char_pool, &add_extra_chars(\$target_string,\@char_pool);
    my $size_of_pool = scalar(@char_pool);

    @input_array = &arrayify($target_string);
    @index_array = &create_array_index(\@input_array);

    do{
	for (0..$#index_array) {
	    $guess[$index_array[$_]] = $char_pool[int(rand($size_of_pool))];
	}
	@index_array = &cmp_by_index(\@input_array,\@index_array,\@guess);
    }while(scalar(@index_array) != 0);
}

sub add_extra_chars() {
    my $target_string = ${shift(@_)};
    my @char_pool = @{shift(@_)};
    my %char_pool = ();
    my @extra_chars = ();
    
    foreach (@char_pool) {
	$char_pool{$_}++;
    }

    for (0..length($target_string)-1) {
	my $the_char = substr $target_string,$_,1;
	push(@extra_chars,$the_char) unless (exists $char_pool{lc($the_char)});
    }
    return @extra_chars;
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
    my @input_array = @{$_[0]};
    my @index_array = ();

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

    if (scalar(@input_array1) != scalar(@input_array2)) {
	print "String lengths are not equal. Exiting...\n";
	exit -1;
    }

    for (my $i = $#index_array1; $i >= 0; $i--) {
	splice(@index_array_copy,$i,1) if (lc($input_array1[$index_array1[$i]]) eq lc($input_array2[$index_array1[$i]]));
    }
    print @input_array2,"\n";
    return @index_array_copy;
}
