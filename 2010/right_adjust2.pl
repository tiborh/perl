#!/usr/bin/perl -w

use strict;

my $width = 0;
my @in_array = ();

print("the width of the text: ");
chomp($width = <STDIN>);

print("and now the lines to print:\n");
chomp(@in_array = <STDIN>);
&ruler($width);
foreach (@in_array) {
    printf("%${width}s\n",$_);
}

sub ruler {
    my $i = 0;

    for($i=0; $i<$_[0]; $i++) {
	print(($i+1) % 10);
    }

    print "\n";
}
