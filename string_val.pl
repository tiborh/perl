#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use Carp::Assert; # get from cpan
use utf8;
use autodie;
#use diagnostics;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;
use Scalar::Util qw(looks_like_number);

binmode(STDOUT, ":utf8");

my $DEBUG = 0;
my $num_of_args = scalar(@ARGV);
my $numval = "Numeric value is expected for arguments.";
my $intval = "Integer is expected for arguments.";

if ($num_of_args < 2) {
    say "Usage: $0 <integer to convert> <base:1-10>";
    exit(1);
}
assert(looks_like_number($ARGV[0]),$numval);
assert(looks_like_number($ARGV[1]),$numval);

my $result = &strval($ARGV[0],$ARGV[1]);
say "the result: " . $result;

sub strval () {
    my $num = shift;
    my $base = shift;
    return "-" . &string_value(-$num, $base) if ($num < 0);
    return &string_value($num, $base);
}

sub string_value() {
    my $num = shift;
    my $base = shift;
    return "" if $num == 0;
    assert(&is_integer($num),$intval);
    assert(&is_integer($base),$intval);
    assert($base >= 2,"Base should not be less than 2.");
    assert($base <= 10,"Base should not be greater than 10.");
    if ($DEBUG) {
	say "the substring part: " 
	    . substr("0123456789",$num % $base,1) 
	    . " (num % base: $num % $base)";
	say "int num / base: " . int $num / $base;
    }
    return &string_value(int $num/$base, $base) . substr("0123456789",$num % $base,1);
}

sub is_integer() {
    return $_[0] =~ /^\s*[\+\-]?\d+\s*$/;
}
