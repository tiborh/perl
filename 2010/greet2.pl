#!/usr/bin/perl -w

use 5.010;

foreach (1..4) {
    printf ("Your name, please: \n");
    chomp(my $name = <STDIN>);
    &greet($name);
}

sub greet {
    state @names;
    
    if (!@names) {
	printf("Hi $_[0]! You are the first one here!\n");
    }
    else {
	printf("Hi $_[0]! I've seen: @names\n");
    }
    push(@names,$_[0]);
}
# end of greet2.pl
