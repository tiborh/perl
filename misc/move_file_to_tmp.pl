#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

use File::Basename;

binmode(STDOUT, ":utf8");

$ARGV[0] ? &move_to_tmp($ARGV[0]) : die "file path is needed as first argument";

sub move_to_tmp {
    my $fnp = shift;
    my $nfp;
    if (-e $fnp) {
	my $bn = basename($fnp);
	$nfp = "/tmp/".$bn;
	rename($fnp,$nfp);
    } else {
	say "file not found: $fnp";
    }
    return $nfp;
}
