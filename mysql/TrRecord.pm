#!/usr/bin/env perl

use warnings;
use 5.014; 			# implies strict
use Carp;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

package TrRecord v0.0.1 {

    sub new
{
    my $class = shift;
    my $self = {
	eriref => shift,
	priority => shift,
	status => shift,
	product => shift,
	product_state => shift,
	designation => shift,
	regmho => shift,
	regdate => shift,
	designdate => shift,
	mhodate => shift,
	designmho => shift,
    };
    foreach (keys %{$self})
    {
	$self->{$_} = "null" if !defined($self->{$_});
    }
    bless $self, $class;
    return $self;
}

sub print_self
{
    my( $self ) = @_;
    print("$_: \t",(defined($self->{$_}) ? "$self->{$_}" : "null"),"\n") foreach (sort keys %{$self});
    print "\n";
}
}
1;
