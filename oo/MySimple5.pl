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
my $min_required_version = 0.0.8;
$CLASS_TO_TEST->VERSION($min_required_version);

my %ts = qw(1 一 2 二 3 三 4 四 5 五);
my $tvs = $CLASS_TO_TEST->new(%ts);
my $oid = "_OID";

{
    my $m2t = "getVal";		  # method to test
    print "$m2t() tests: ";
    assert(!$tvs->$m2t());
    my $tp = "1";
    assert($tvs->$m2t($tp) eq "一");
    $tp = "6";
    assert(!$tvs->$m2t($tp));
    assert(!$tvs->$m2t($oid)); # _ keys are filtered out
    say "passed";
}

{
    print "getKeys() test: ";
    my @testKeys = sort keys %ts;
    my @receivedKeys = $tvs->getKeys();
    #push @testKeys,$oid; # _ keys are filtered out
    no warnings 'experimental::smartmatch';
    assert(@receivedKeys ~~ @testKeys);
    say "passed";
}

{
    my $m2t = "setVal";		  # method to test
    my $tp = "6";
    print "$m2t() tests: ";
    assert(!$tvs->$m2t());
    assert(!$tvs->$m2t($tp));
    assert(!$tvs->$m2t(5));
    assert(!$tvs->$m2t($oid,2));
    assert(!$tvs->$m2t($tp,"六"));
    my $tv = "五（ご）";
    assert($tvs->$m2t(5,$tv) eq $tv);
    say "passed";
}

{
    my $m2t = "addKeyVal";	# method to test
    my $otk = "5";
    my $ntk = "6";
    my $ntv = "六";
    print "$m2t() tests: ";
    assert(!$tvs->$m2t());
    assert(!$tvs->$m2t($otk));
    assert(!$tvs->$m2t($otk,$ntv));
    my @np = ($ntk,$ntv);
    my @rv = $tvs->$m2t($ntk,$ntv);
    no warnings 'experimental::smartmatch';
    assert(@np ~~ @rv);
    say "passed";
}

{
    my $m2t = "setKey";		  # method to test
    print "$m2t() tests: ";
    my $otk = "6";		# old test key
    my $ntk = "six";		# new test key
    my $otv = $tvs->getVal($otk); # old test value
    assert(!$tvs->$m2t());
    assert(!$tvs->$m2t($ntk));
    assert(!$tvs->$m2t($otk));
    assert(!$tvs->$m2t($ntk,$otk));
    assert(!$tvs->$m2t($oid,"ID"));
    my @np = ($ntk,$otv);
    my @rp = $tvs->$m2t($otk,$ntk);
    no warnings 'experimental::smartmatch';
    assert(@np ~~ @rp);
    say "passed";
}

{
    my $m2t = "getID";		  # method to test
    print "$m2t() tests: ";
    my $tk = "_testID";
    my $tv = "test value";
    $tvs->addKeyVal($tk,$tv);
    assert($tvs->$m2t() eq "1");
    assert($tvs->$m2t($oid) eq "1");
    assert($tvs->$m2t($tk) eq $tv);
    say "passed";
}
    
say "listing value per key";
say "\t$_ => ",$tvs->getVal($_) foreach ($tvs->getKeys());

say "printSelf() test:";
$tvs->printSelf("\t");

use test_package;
TestPackage::list_package_vars($CLASS_TO_TEST);
