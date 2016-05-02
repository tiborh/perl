#!/usr/bin/perl -w

@list1 = ('a','b','c','d');
@list2 = ('e','f','g','h');

$, = " ";

print "list1 (before push):",@list1,"\n";

@list3 = push(@list1,@list2);

print "list1 (after push):",@list1,"\n";
print "list2:",@list2,"\n";
print "list3:",@list3,"\n";
