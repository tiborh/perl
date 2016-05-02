#!/usr/bin/env perl

use warnings;
use v5.14; 			# implies strict
use Carp;
use Carp::Assert;
use utf8;
use autodie;
#the following two needs installation:
#use Modern::Perl;
#use Test::More;

binmode(STDOUT, ":utf8");

use RstateStep;

my @valid_rsts = qw(r1a p1a r11z P31F r1a01 r1a10 r4b/2 R5C/21 r6e/10);
my @invalid_rsts = qw(a1a a 1 12 pa1 r1 pb); 

say "Validity tests:";
say "\tTesting valid r-states:";
my $success = 1;
foreach (@valid_rsts) {
    eval {
	assert(RstateStep::checkRst($_));
    };
    if ($@) {
	$success = 0;
	carp "\t\t $_: failed"
    }
}
say $success ? "\tpassed" : "\tfailed";

$success = 1;
say "\tTesting invalid r-states:";
foreach (@invalid_rsts) {
    eval {
	assert(!RstateStep::checkRst($_));
    };
    if ($@) {
	$success = 0;
	carp "\t\t $_: failed"
    }
}
say $success ? "\tpassed" : "\tfailed";

print "Stepping tests: ";
assert(!RstateStep::stepRst());
assert(!RstateStep::stepRst("r1a"));
assert(RstateStep::stepRst("r1a","major"));
assert(RstateStep::stepRst("p91b","miNo"));
assert(!RstateStep::stepRst("r1z","m"));
assert(!RstateStep::stepRst("zzz","minor"));
assert(!RstateStep::stepRst("r1","ma"));
assert(RstateStep::stepRst("r1a","ma"));
assert(RstateStep::stepRst("r1a","ma") eq "r2a");
assert(RstateStep::stepRst("r1a","mi") eq "r1b");
assert(RstateStep::stepRst("r1a/1","ep") eq "r1a/2");
say "passed";

print "regDebug tests: ";
my @retarr = RstateStep::regDebug("r1a00");
my @exparr = qw(r 1 a 00);
no warnings 'experimental::smartmatch';
assert(@retarr ~~ @exparr);
@retarr = RstateStep::regDebug("r1a/1");
@exparr = qw(r 1 a /1);
assert(@retarr ~~ @exparr);
@retarr = RstateStep::regDebug("r21a");
@exparr = qw(r 21 a);
$exparr[3] = undef;
assert(@retarr ~~ @exparr);
say "passed";

