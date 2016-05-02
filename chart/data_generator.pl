#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

my $fh;
my $fm = '>';
my $fn = 'data.dat';

open($fh,$fm,$fn) or die "Cannot open $fn, $!";

my $endpoint = scalar(@ARGV) > 0 ? int($ARGV[0]) : 1000;

select($fh);
for (0..$endpoint) {
    say join "\t",$_,rand();
}
select(STDOUT);

close($fh);


