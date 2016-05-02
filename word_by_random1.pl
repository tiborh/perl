#!/usr/bin/perl -w

use strict;

&main;

sub main() {
    my $target_string = $ARGV[0] ? $ARGV[0] : "Meth";
    my @char_pool = ("a".."z");
    my $size_of_pool = scalar(@char_pool);
    my $guess = "";
    my $start_time = 0;
    my $end_time = 0;

    print $target_string,"\n";
    $start_time = time();

    do{
	$guess = "";
	for (1..length($target_string)) {
	    $guess .= $char_pool[int(rand($size_of_pool))];
	}
	#print $guess,"\n";
    }while($guess ne lc($target_string));

    $end_time = time();

    printf("Run time: %d seconds\n",$end_time - $start_time);
}
