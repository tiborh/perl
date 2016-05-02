#!/usr/bin/perl -w

$NUM = 10;
$MAXINT = 5000;

srand(); #seeding the random function

print "Numbers generated:\n(";
for $i (1 .. $NUM)
{
    push @Array, sprintf("%d", rand(1) * $MAXINT);
    print $Array[$i-1]," (";
    if (($Array[$i-1]>>1)<<1 != $Array[$i-1])
    {
	print "odd";
    }
    else
    {
	print "even";
    }
    print ")";
    print ", " unless ($i == $NUM);
}
print ")\n\n";
