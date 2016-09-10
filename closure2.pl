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

sub hop_along {
    my ($from, $to, $step) = @_;
    my $next = $from-$step;
    my $closure_ref = sub {
	$next+=$step;           # Take a step
	#say "$next";
	return if $next > $to;  # undef if out of range
	$_[0] = $next;          # Otherwise set new value >>> side effect <<<
	return 1;               # and succeed
    };
    return $closure_ref;# Return closure
}

my ($from,$to,$step) = (1, 100, 7);
say "from: $from, to: $to, step: $step";
my $iterator = &hop_along($from,$to,$step);
my $next;
say "next: $next" while ($iterator->($next));

my $rows = 20;
my $cols = 80;
say "a rectangle of dots size $rows by $cols";
my $row = &hop_along(1, $rows, 1);
my $r;
while ($row->($r)) {
    my $col = &hop_along(1, $cols, 2);
    my $c;
    while ($col->($c)) {
	print ".";
    }
    say "";
}
