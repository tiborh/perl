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
use File::Basename;

my $bn = (split /\./,basename($0))[0];

use Chart::Clicker;

my $cc = Chart::Clicker->new;

my @values = (42, 25, 86, 23, 2, 19, 103, 12, 54, 9);
$cc->add_data('Sales', \@values);

# alternately, you can add data one bit at a time...
foreach my $v (@values) {
    $cc->add_data('Sales', $v);
}

# Or, if you want to specify the keys you can use a hashref
my $data = { 12 => 123, 13 => 341, 14 => 1241 };
$cc->add_data('Sales', $data);

$cc->write_output("$bn.png");

