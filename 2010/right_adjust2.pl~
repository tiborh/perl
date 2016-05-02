#!/usr/bin/perl -w

use strict;

my $width = 0;
my @in_array = ();

print("the width of the text: ");
chomp($width = <STDIN>);

print("and now the lines to print:\n");
chomp(@in_array = <STDIN>);
&ruler($width,0);
foreach (@in_array) {
    printf("%${width}s\n",$_);
}


sub ruler {
    my $width = $_[0];
    my $ruler = "";
    my $remainder = 0;
    my $str_len = 0;
    my $multip = 0;

    $ruler = join("",0..9);
    $str_len = length($ruler);
    $remainder = $width % $str_len;
    $multip = int($width / $str_len) + ($remainder > 0 ? 1 : 0);

    print $ruler x $multip,"\n";

    if ($_[1] != 0) {
	print $ruler,"\n";
	print $str_len,"\n";
	print $remainder,"\n";
	print $multip,"\n";
    }
}
