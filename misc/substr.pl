#!/usr/bin/perl -w

use strict;
use utf8;

binmode STDOUT,':utf8';

#to test the basic capabilities of substr
#syntax:
# 1. substr EXPR,OFFSET
# 2. substr EXPR,OFFSET,LENGTH
# 3. substr EXPR,OFFSET,LENGTH,REPLACEMENT
# EXPR: the target string
# OFFSET: the index where the change starts
# LENGTH: the length of the affected substring
# REP...: the substring fragment to replace the above

my $test_string = "案ずるより産むが易し";
my $ひらがな = "あんずるよりうむがやさし";
my $英語 = "Attempt is sometimes easier than expected.";

# if utf8 is not used result is 30, if used 10
my $str_length = length $test_string;

print "The length of the string: $str_length\n";
print $test_string, "\n";
print $ひらがな, "\n";
print $英語, "\n\n";

# 1.
print "substr with two arguments:\n";
my $remaining = substr($test_string,5);
print "$test_string\n";
print "$remaining\n";

# 2.
print "substr with three arguments:\n";
$remaining = substr($test_string,5,3);
print "$test_string\n";
print "$remaining\n";

# 3.
print "substr with four arguments:\n";
$remaining = substr($test_string,5,1,"う");
print "$test_string\n";
print "$remaining\n";

# 4. negative third argument counts back from back
print "substr with three arguments, negative third:\n";
$remaining = substr($test_string,5,-2);
print "$test_string\n";
print "$remaining\n";

# 5. 
print "delete is done with an empty string as a fourth argument:\n";
$remaining = substr($test_string,5,1,"");
print "$test_string\n";
print "$remaining\n";

# 6.
print "insert: 4 args, 3rd is zero:\n";
$remaining = substr($test_string,5,0,"産");
print "$test_string\n";
print "$remaining\n";


# 案ずる
# 1. to be anxious or concerned about;  to ponder (anxiously);  to fear
# 2. to investigate;  to consider;  to plan
# 3. 【按ずる】to pat;  to rub;  to take a sword in one's hand
# 案 (アン つくえ)
# plan;  suggestion;  draft;  ponder;  fear;  proposition;  
# idea;  expectation;  bill;  worry
# 産む
# to give birth;  to deliver;  to produce
# 産 (サン う·む う·まれる う·ぶー む·す)
# products;  bear;  give birth;  yield;  childbirth;  native;  property
# 易しい
# easy;  plain;  simple
# 易 エキ イ やさ·しい やす·い (1. cheap, inexpensive; 2. 安い calm;  peaceful;  quiet)
# easy;  ready to;  simple;  fortune-telling;  divination
