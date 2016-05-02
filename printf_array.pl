#!/usr/bin/perl -w

use strict;

my @table_head = ();
my @table_body = ();
my $nuOfCols = 4;
my $nuOfRows = 10;
my $wl = 9;
my $wls = "%$wl"."s";
my $wlf = "%$wl".".2f";

for(my $i = 0; $i < $nuOfCols; $i++) {
    $table_head[$i] = &gen_word($wl-2);
}

for(my $i = 0; $i < $nuOfRows; $i++) {
    for(my $j = 0; $j < @table_head; $j++) {
	$table_body[$i][$j] = rand(100);
    }
}

&print_border("=",$wl,scalar(@table_head));
printf(($wls x @table_head)."\n", @table_head);
&print_border("-",$wl,scalar(@table_head));
foreach my $xrows (@table_body) {
    printf(($wlf x @table_head)."\n",@$xrows);
}
&print_border("=",$wl,scalar(@table_head));

sub print_border {
    print(("$_[0]" x ($_[1] * $_[2] + 2))."\n");
}

sub gen_word {
    my $gword = "";
    for (my $i = 0; $i < $_[0]; $i++) {
    $gword .= sprintf("%c",97+int(rand(26)));
    }
    return $gword;
}
