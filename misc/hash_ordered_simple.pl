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

use Tie::IxHash;

tie my(%seasons) = Tie::IxHash->new(qw(春 はる 夏 なつ 秋 あき 冬 ふゆ));
my $days = Tie::IxHash->new(qw(日 にち 月 げつ 火 か 水 すい 木 もく 金 きん 土 ど));
&basic_properties($seasons);
&basic_properties($days);
my $t = Tie::IxHash->new(seasons => $seasons, days => $days);
say "object reference (outside sub): ",ref($t);
&basic_properties($t);
say "pick out one: ",%{%{$t=>{"seasons"}}=>{"春"}};

sub basic_properties {
    my $t = shift || return;

    say "object reference (in sub): ",ref($t);
    say "Length: ",$t->Length;
    $, = "  ";
    say "Keys: ", $t->Keys ;
    say "Values: ",$t->Values;
 
    return(0);
}

# $t->Push(fourth => 4); # same as $myhash{'fourth'} = 4;
# my ($k, $v) = $t->Pop;    # $k is 'fourth', $v is 4
# $t->Unshift(neg => -1, zeroth => 0); 
# ($k, $v) = $t->Shift;  # $k is 'neg', $v is -1
# my @oneandtwo = $t->Splice(1, 2, foo => 100, bar => 101);

# @keys = $t->Keys;
# @values = $t->Values;
# my @indices = $t->Indices('foo', 'zeroth');
# my @itemkeys = $t->Keys(@indices);
# my @itemvals = $t->Values(@indices);
# $t->Replace(2, 0.3, 'other');
# $t->Delete('second', 'zeroth');
# my $len = $t->Length;     # number of key-value pairs

# $t->Reorder(reverse @keys);
# $t->SortByKey;
# $t->SortByValue;
