#!/usr/bin/perl -w

use strict;
use utf8;

binmode STDOUT,':utf8';

#to test the basic capabilities of splice
#syntax:
# 0. splice ARRAY 
# 1. splice ARRAY,OFFSET
# 2. splice ARRAY,OFFSET,LENGTH
# 3. splice ARRAY,OFFSET,LENGTH,LIST
# ARRAY: the target array
# OFFSET: the index where the change starts
# LENGTH: the length of the affected subarray
# LIST: the subarray fragment to replace the above

my @test_array = qw(一 二 三 四 五 六 七 八 九 十);
my @backup_array = @test_array;
#print "$#test_array\n";

# 0. 
print "splice with one argument (everything is removed):\n";
my @remaining = splice(@test_array);
print "@test_array\n";
print "@remaining\n";
@test_array = @backup_array;

# 1.
print "splice with two arguments (everything removed from offset):\n";
@remaining = splice(@test_array,5);
print "@test_array\n";
print "@remaining\n";
@test_array = @backup_array;

# 2.
print "splice with three arguments (items removed from offset till end of length):\n";
@remaining = splice(@test_array,5,3);
print "@test_array\n";
print "@remaining\n";
@test_array = @backup_array;

# 3.
print "splice with four arguments (replacement of cut away part):\n";
@remaining = splice(@test_array,5,1,"るく");
print "@test_array\n";
print "@remaining\n";
@test_array = @backup_array;

# 4. negative third argument counts back from back
print "splice with three arguments, negative third:\n";
@remaining = splice(@test_array,5,-2);
print "@test_array\n";
print "@remaining\n";
@test_array = @backup_array;

# 5. 
print "delete is done with 3 args, 3rd is 1:\n";
@remaining = splice(@test_array,5,1);
print "@test_array\n";
print "@remaining\n";

# 6.
print "insert: 4 args, 3rd is zero:\n";
@remaining = splice(@test_array,5,0,"６");
print "@test_array\n";
print "@remaining\n";

# 7.
print "pop: 2nd -1, 3rd: 1\n";
@remaining = splice(@test_array,-1,1);
print "@test_array\n";
print "@remaining\n";

# 8.
print "push: 2nd <the array>, 3rd: 0, 4th: <new item>\n";
@remaining = splice(@test_array,@test_array,0,"１０");
print "@test_array\n";
print "@remaining\n";

# 9.
print "shift: 2nd 0, 3rd: 1\n";
@remaining = splice(@test_array,0,1);
print "@test_array\n";
print "@remaining\n";

# 10.
print "unshift: 2nd 0, 3rd: 0, 4th: <new item>\n";
@remaining = splice(@test_array,0,0,"１");
print "@test_array\n";
print "@remaining\n";
