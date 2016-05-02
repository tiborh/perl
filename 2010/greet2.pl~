#!/usr/bin/perl -w

use 5.010;

printf ("Give me a name: \n");
chomp(my $name = <STDIN>);
&greet($name);
printf ("Give me another name: \n");
chomp($name = <STDIN>);
&greet($name);

sub greet {
    state $name = "";

    if ($name eq "") {
	printf("Hi $_[0]! You are the first one here!\n");
	$name = $_[0];
    }
    else {
	printf("Hi $_[0]! $name is already here!\n");
    }
}
# end of greet.pl
