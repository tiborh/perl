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
use File::Spec;

binmode(STDOUT, ":utf8");

my $cmd = basename($0);

if (scalar(@ARGV) < 2) {
    say "Usage: $cmd <from file path> <to directory>";
    exit(1);
}
&move_to_dir($ARGV[0],$ARGV[1]);
exit(0);

sub move_to_dir {
    my $fnp = shift;
    unless (-e $fnp) {
	say "file not found: $fnp";
	exit(1);
    }
    my $np = shift;
    unless (-e $np) {
	say "file does not exist: $np";
	exit(1);
    }
    unless (-d $np) {
	say "not a directory: $np";
	exit(1);
    }

    my $bn = basename($fnp);
    my $nfp = File::Spec->catfile($np,$bn);
    say "$fnp => $nfp";
    rename($fnp,$nfp);
    return $nfp;
}
