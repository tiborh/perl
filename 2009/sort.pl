#!/usr/bin/perl -w

@Array = ("alphA","aLpha","álpha","beTa","gAmma","DElTA","12epsilon");

@NumArray = (12,4.5,101,-0.12);

$, = " ";

print "--\tunsorted:\n";
print @Array,"\n";

print "--\tdefault sorted:\n";
print sort(@Array),"\n";
print "--\tlower case sorted:\n";
print sort(map(lc($_),@Array)),"\n";
print "--\tdescending sorted:\n";
print sort { $b cmp $a } @Array;
print "\n";
print "--\tlexographically sorted:\n";
print sort { $a cmp $b } @NumArray;
print "\n";
print "--\tdescending lexographically sorted:\n";
print sort { $b cmp $a } @NumArray;
print "\n";

print "--\tnumerically sorted:\n";
print sort { $a <=> $b } @NumArray;
print "\n";
print "--\tdescending numerically sorted:\n";
print sort { $b <=> $a } @NumArray;
print "\n";
