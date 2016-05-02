#!/usr/bin/env perl

use warnings;
use v5.18; 			# implies strict
#use strict;
use Carp;
use Carp::Assert;
use utf8;
#use encoding 'utf8';
use autodie;
#use Modern::Perl;
#use Test::More;
use MySimple;

binmode(STDOUT, ":utf8");

my $CLASS_TO_TEST = "MySimple";
my $min_required_version = 0.0.5;
$CLASS_TO_TEST->VERSION($min_required_version);

my %ts = qw(1 一 2 二 3 三 4 四 5 五);
# say "test set:";
# say "\t$_ => $ts{$_}" foreach (sort keys %ts);
my $tvs = $CLASS_TO_TEST->new(%ts);

{
    print "getVal() tests: ";
    assert(!$tvs->getVal());
    my $tp = "1"; assert($tvs->getVal($tp) eq "一");

    $tp = "6"; assert(!$tvs->getVal($tp));
    say "passed";
}

{
    print "getKeys() test: ";
    my @testKeys = sort keys %ts;
    my @receivedKeys = $tvs->getKeys();
    no warnings 'experimental::smartmatch';
    assert(@receivedKeys ~~ @testKeys);
    say "passed";
}

{
    my $tp = "6";
    print "setVal() tests: ";
    assert(!$tvs->setVal());
    assert(!$tvs->setVal($tp));
    assert(!$tvs->setVal(5));
    assert(!$tvs->setVal($tp,"六"));
    my $tv = "五（ご）";
    assert($tvs->setVal(5,$tv) eq $tv);
    say "passed";
}
    
say "listing value per key";
say "\t$_ => ",$tvs->getVal($_) foreach ($tvs->getKeys());

# say "printSelf() test:";
# $tvs->printSelf("\t");

use test_package;
TestPackage::list_package_vars($CLASS_TO_TEST);
