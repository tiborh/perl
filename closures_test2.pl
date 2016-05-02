#!/usr/bin/env perl

use warnings;
use strict;
#use Modern::Perl;
use Carp;
use utf8;
use encoding 'utf8';

my $DEBUG = 1;

print "Initialising test var:\n" if $DEBUG;
my $test = &gen_fib();
print "Starting to call initialised var:\n" if $DEBUG;
print "The result: ",$test->($_),"\n" foreach (0..12);


sub gen_fib {
    my @fibs = (0, 1, 1);
    print "inside gen_fib():\n";

    return gen_caching_closure(
	sub {
	    my ($item, $fibs) = @_;
	    if ($DEBUG) {
		print "inside the return of gen_fib():\n";
		print "\titem: $item\n";
		print "\tfibs: $fibs (@$fibs)\n";
	    }

	    for my $calc ((@$fibs - 1) .. $item) {
		print "inside fib calc\n" if $DEBUG;
		$fibs->[$calc] = $fibs->[$calc - 2] + $fibs->[$calc - 1];
	    }
	},
	@fibs
        );
}

sub gen_caching_closure {
    my ($calc_element, @cache) = @_;
    if ($DEBUG) {
	print "Inside gen_caching_closure():\n";
	print "\tcalc element: $calc_element\n";
	print "\tcache: @cache\n";
    }
    
    return sub {
	my $item = shift;
	
	if ($DEBUG) {
	    print "inside the return of gen_caching_closure():\n";
	    print "\titem: $item\n";
	}
	$calc_element->($item, \@cache) unless $item < @cache;
	
	return $cache[$item];
    };
}
